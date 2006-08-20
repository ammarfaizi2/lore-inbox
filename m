Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWHTTh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWHTTh5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 15:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWHTTh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 15:37:57 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:39176 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751174AbWHTTh4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 15:37:56 -0400
To: "Irfan Habib" <irfan.habib@gmail.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: Re: question on pthreads
References: <3420082f0608201046q53bb60b5u5ca8915e588ee9e3@mail.gmail.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: it's like swatting a fly with a supernova.
Date: Sun, 20 Aug 2006 20:37:52 +0100
In-Reply-To: <3420082f0608201046q53bb60b5u5ca8915e588ee9e3@mail.gmail.com> (Irfan Habib's message of "20 Aug 2006 18:46:49 +0100")
Message-ID: <87k653yz8v.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Aug 2006, Irfan Habib suggested tentatively:
> Hi,
> 
> Where should I look for the code of the native Pthreads implemetation:
> 
> I've found this:
> http://pauillac.inria.fr/~xleroy/linuxthreads/
> 
> Supposedly from the site,it has been superceeded by NPTL by Ulrich
> Drepper, but I cant find the code for NPTL?

It is in glibc.

-- 
`We're sysadmins. We deal with the inconceivable so often I can clearly 
 see the need to define levels of inconceivability.' --- Rik Steenwinkel
