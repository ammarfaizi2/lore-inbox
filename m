Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270084AbUJEQAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270084AbUJEQAf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 12:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269196AbUJEPwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 11:52:10 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:48831 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S269549AbUJEPp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 11:45:28 -0400
Message-ID: <4162C192.1020402@namesys.com>
Date: Tue, 05 Oct 2004 08:45:22 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeffrey Mahoney <jeffm@novell.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] I/O Error Handling for ReiserFS v3
References: <20041005150819.GA30046@locomotive.unixthugs.org>
In-Reply-To: <20041005150819.GA30046@locomotive.unixthugs.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffrey Mahoney wrote:

>Hey all -
>
>One of the most common complaints I've heard about ReiserFS is how
>graceless it is in handling critical I/O errors.
>
>  
>
I would like to thank Jeff for writing these.  They are much needed.
