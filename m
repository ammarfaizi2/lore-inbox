Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbWF0Tke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbWF0Tke (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbWF0Tke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:40:34 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:7476 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030320AbWF0Tkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:40:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YiNfMC+Z3u4DYE3xEx3zsTYXRn1JnNR5YptCUqTgdpGZpkT41zzLqHin620r3Q4LmOVjJM7AqxvMcFoDGG2mEhOpvJFNyPB9A0ginDuzboWNsI9Fq0npg+PwTnnXWn/EY2SF2F3NpJXiZiSRz8E0/mowwwafA48+7Vvy+fPqnps=
Message-ID: <d120d5000606271240v76d3f159j1615ad0b16ad8e68@mail.gmail.com>
Date: Tue, 27 Jun 2006 15:40:31 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [git pull] Input update for 2.6.17
Cc: "Greg KH" <greg@kroah.com>, "Andrew Morton" <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0606271231440.3927@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200606260235.03718.dtor_core@ameritech.net>
	 <Pine.LNX.4.64.0606262247040.3927@g5.osdl.org>
	 <20060627063734.GA28135@kroah.com>
	 <Pine.LNX.4.64.0606271131590.3927@g5.osdl.org>
	 <Pine.LNX.4.64.0606271211110.3927@g5.osdl.org>
	 <Pine.LNX.4.64.0606271231440.3927@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
> followed by the oops:
>
>        BUG: spinlock bad magic on CPU#0, khubd/131
>        BUG: unable to handle kernel paging request at virtual address 6b6b6c0b
>        ....
>
> which just doesn't tell me anything.
>

Linus,

Are you dropping mails with attachments or maybe you have not gone
through all your email, because I believe the patch I send to you
should fix the problem.

-- 
Dmitry
