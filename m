Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWFZR5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWFZR5x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 13:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWFZR5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 13:57:53 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:55050 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751236AbWFZR5w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 13:57:52 -0400
To: linux-kernel@vger.kernel.org
Cc: kai@germaschewski.name, Sam Ravnborg <sam@ravnborg.org>,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Fix 100% initramfs bloat in 2.6.17 versus 2.6.16
References: <87psh3mnay.fsf@hades.wkstn.nix>
From: Nix <nix@esperi.org.uk>
X-Emacs: (setq software-quality (/ 1 number-of-authors))
Date: Mon, 26 Jun 2006 18:57:45 +0100
In-Reply-To: <87psh3mnay.fsf@hades.wkstn.nix> (nix@esperi.org.uk's message of "21 Jun 2006 00:15:48 +0100")
Message-ID: <87mzbzhk9y.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Jun 2006, nix@esperi.org.uk stipulated:
> It didn't take long to work out that this was because my initramfs's
> contents were being included twice in the cpio image.

Ping? Anyone?

-- 
`NB: Anyone suggesting that we should say "Tibibytes" instead of
 Terabytes there will be hunted down and brutally slain.
 That is all.' --- Matthew Wilcox
