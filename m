Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbVLHNs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbVLHNs4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 08:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVLHNsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 08:48:55 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:3590 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751181AbVLHNsz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 08:48:55 -0500
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux in a binary world... a doomsday scenario
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	<1133807641.9356.50.camel@laptopd505.fenrus.org>
	<4395BBDB.307@ti-wmc.nl> <200512061850.20169.luke-jr@utopios.org>
	<4397EB7A.7030404@aitel.hist.no>
From: Nix <nix@esperi.org.uk>
X-Emacs: the prosecution rests its case.
Date: Thu, 08 Dec 2005 13:48:48 +0000
In-Reply-To: <4397EB7A.7030404@aitel.hist.no> (Helge Hafting's message of "8
 Dec 2005 08:11:40 -0000")
Message-ID: <87hd9jvgvz.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Dec 2005, Helge Hafting said:
> Lucky you.  Mine doesn't.  Using 3D on it makes the machine unstable,
> and the performance is apalling too. So I'm looking for something
> else - a radeon 7000 is cheap .  . .

Backtraces? X version? X config?

(FWIW, my AGP Radeon 9250 works flawlessly as of X.org 6.8.99.901.
6.8.2 and earlier were wobbly.)

Whether performance is appalling I don't know because I don't have any
standards to measure it by, but I get 2000fps or thereabouts out of
glxgears. That's a hell of a lot better than the 64fps I got out of
my earlier mach64 :)

> And don't say that a crash during a 3D game isn't important - it is
> a two-user machine and the other user is not amused when this happens.

Agreed. If you can handle a brief possibility of deadlocking then you
can get a backtrace when X dies, which is very useful:
<http://xorg.freedesktop.org/wiki/DebuggingTheXserver>.

-- 
`Don't confuse the shark with the remoras.' --- Rob Landley

