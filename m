Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbULOFbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbULOFbv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 00:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbULOFbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 00:31:51 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:47559 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261896AbULOFbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 00:31:46 -0500
Message-ID: <41BFCC47.4050700@namesys.com>
Date: Tue, 14 Dec 2004 21:31:51 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>,
       reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: file as a directory
References: <200412141930.iBEJUGdB019336@laptop11.inf.utfsm.cl> <41BFC2FC.80905@slaphack.com>
In-Reply-To: <41BFC2FC.80905@slaphack.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover wrote:

>
>
> Remember that a filesystem is a specialized database. It is specialized
> for performance. 

Yes, this is exactly right.  The reason earlier efforts to generalize 
filesystems failed was performance, and the reason performance reduced 
was a lack of hard work on the problem.

