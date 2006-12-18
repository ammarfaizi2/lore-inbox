Return-Path: <linux-kernel-owner+w=401wt.eu-S1753397AbWLRGuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbWLRGuv (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 01:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753398AbWLRGuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 01:50:50 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:55827 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397AbWLRGuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 01:50:50 -0500
From: Junio C Hamano <junkio@cox.net>
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Alexandre Oliva <aoliva@redhat.com>,
       Ricardo Galli <gallir@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules
References: <200612161927.13860.gallir@gmail.com>
	<Pine.LNX.4.64.0612161253390.3479@woody.osdl.org>
	<orwt4qaara.fsf@redhat.com>
	<Pine.LNX.4.64.0612170927110.3479@woody.osdl.org>
	<17797.51337.364669.628160@cargo.ozlabs.ibm.com>
Date: Sun, 17 Dec 2006 22:50:47 -0800
In-Reply-To: <17797.51337.364669.628160@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Mon, 18 Dec 2006 09:45:29 +1100")
Message-ID: <7vhcvt3dfc.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> writes:

> Linus Torvalds writes:
>
>> Why do people think that using "ln" is _any_ different from using 
>> "mkisofs". Both create one file that contains multiple pieces. What's the 
>> difference - really?
>
> The difference - really - at least for static linking - is that "ln"
> makes modifications to each piece to make them work together, and in
> the case of a library, makes a selection of the parts of the library
> as needed by the rest of the program.

Excuse me, but are you two discussing "ld"? ;-)

