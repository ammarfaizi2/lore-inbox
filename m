Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbVCNJha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVCNJha (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 04:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbVCNJfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 04:35:13 -0500
Received: from one.firstfloor.org ([213.235.205.2]:28844 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262084AbVCNJeb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 04:34:31 -0500
To: Stas Sergeev <stsp@aknet.ru>
Cc: Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       wine-devel@winehq.org, torvalds@osdl.org
Subject: Re: [patch] x86: fix ESP corruption CPU bug
References: <42348474.7040808@aknet.ru> <20050313201020.GB8231@elf.ucw.cz>
	<4234A8DD.9080305@aknet.ru>
	<Pine.LNX.4.58.0503131306450.2822@ppc970.osdl.org>
	<Pine.LNX.4.58.0503131614360.2822@ppc970.osdl.org>
	<423518A7.9030704@aknet.ru>
From: Andi Kleen <ak@muc.de>
Date: Mon, 14 Mar 2005 10:34:28 +0100
In-Reply-To: <423518A7.9030704@aknet.ru> (Stas Sergeev's message of "Mon, 14
 Mar 2005 07:52:55 +0300")
Message-ID: <m14qfey3iz.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev <stsp@aknet.ru> writes:
>
>> Another way of saying the same thing: I absolutely hate seeing
>> patches that fix some theoretical issue that no Linux apps will ever
>> care about.
> No, it is not theoretical, but it is mainly
> about a DOS games and an MS linker, as for
> me. The things I'd like to get working, but
> the ones you may not care too much about:)
> The particular game I want to get working,
> is "Master of Orion 2" for DOS.

How about you just run it in dosbox instead of dosemu ?

-Andi
