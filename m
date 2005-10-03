Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932681AbVJCUCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbVJCUCe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 16:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932682AbVJCUCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 16:02:34 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8330 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932681AbVJCUCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 16:02:33 -0400
Date: Mon, 3 Oct 2005 22:02:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Bernard Blackham <bernard@blackham.com.au>
Cc: 7eggert@gmx.de, Ed Tomlinson <tomlins@cam.org>,
       lokum spand <lokumsspand@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: A possible idea for Linux: Save running programs to disk
Message-ID: <20051003200217.GA2086@elf.ucw.cz>
References: <4SXfo-7hM-9@gated-at.bofh.it> <4T47e-5E-1@gated-at.bofh.it> <4TbLq-2VG-5@gated-at.bofh.it> <4TcR9-4sS-9@gated-at.bofh.it> <E1EM7KO-00014G-CK@be1.lrz> <20051002175116.GE5211@blackham.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051002175116.GE5211@blackham.com.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > What about using an uml wrapper + vncserver?
> 
> Requires consciously doing so when you start it. It most certainly
> could be done that way, but one of cryopid's aims is to work on any
> running process without prior planning.
> 
> Interesting idea though - it'd be somewhat akin to porting
> suspend-to-disk to UML (which has been on suspend2's todo list for a
> while though :)

Better port swsusp1... I was thinking about that, too, but it is going
to be quite complex. Patches certainly welcome.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
