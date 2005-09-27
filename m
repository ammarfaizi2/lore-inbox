Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbVI0Pw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbVI0Pw6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 11:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbVI0Pw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 11:52:58 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:8370 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S964988AbVI0Pw5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 11:52:57 -0400
Message-ID: <43396A6A.30104@cs.aau.dk>
Date: Tue, 27 Sep 2005 17:51:06 +0200
From: Emmanuel Fleury <fleury@cs.aau.dk>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Framework for automatic Configuration of a Kernel
References: <20050927125300.24574.qmail@web51014.mail.yahoo.com>
In-Reply-To: <20050927125300.24574.qmail@web51014.mail.yahoo.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahmad Reza Cheraghi wrote:
> 
> Again another good Idea. Your right;-) Its better. 
> But it better getting another way of detecting the
> Hardware/Software etc. from the System without using
> lspci or the proc-files...? Something that gets all
> the Hardware Information directly from the I/O and not
> from the Kernel. The good thing about lspci is that it
> does both . But it doesnt say if there is  a CDROM or
> floppy-disc... I tryed alot to search for something
> like that but without any success. I heard about this
> Otopia Project. I google after it but I didnt find
> anything usefule. I think its dead. 

I might be wrong, but I don't think that there is any other way to get
hardware information but through the /proc or /sys interface.

Can somebody comment on this ?

Regards
-- 
Emmanuel Fleury

It really is a nice theory. The only defect I think it has is probably
common to all philosophical theories. It's wrong.
  -- Saul Kripke (Naming and Necessity)
