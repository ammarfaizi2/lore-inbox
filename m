Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbUAFMHV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 07:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbUAFMHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 07:07:21 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:63133 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262055AbUAFMHU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 07:07:20 -0500
Message-ID: <3FFAA4F6.5040501@namesys.com>
Date: Tue, 06 Jan 2004 15:07:18 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: venom@sns.it
CC: Steve Glines <sglines@is-cs.com>, linux-kernel@vger.kernel.org
Subject: Re: file system technical comparisons
References: <Pine.LNX.4.43.0401061258030.13594-100000@cibs9.sns.it>
In-Reply-To: <Pine.LNX.4.43.0401061258030.13594-100000@cibs9.sns.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

venom@sns.it wrote:

>That there is something I am not really sure I understood.
>
>Luigi
>
>  
>
balanced trees squish things together at every modification of the 
tree.  Dancing trees squish things together when they get low on ram, 
which is less often.  this means that we can afford to squish tighter 
because we do it less often.

-- 
Hans


