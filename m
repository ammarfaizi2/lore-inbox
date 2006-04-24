Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWDXU0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWDXU0Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWDXU0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:26:24 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:54533 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751223AbWDXU0W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:26:22 -0400
To: Dave Jones <davej@redhat.com>
Cc: Fernando Barsoba <fbarsoba@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: installing older kernel (2.4.20/28 on machine running 2.6.15)
References: <20060423192949.GA13666@stusta.de>
	<BAY114-F395006CC148F4F61BFB684C7B90@phx.gbl>
	<20060423202657.GD14680@redhat.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: because editing your files should be a traumatic experience.
Date: Mon, 24 Apr 2006 21:26:07 +0100
In-Reply-To: <20060423202657.GD14680@redhat.com> (Dave Jones's message of "23 Apr 2006 21:28:31 +0100")
Message-ID: <87lktupvog.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Apr 2006, Dave Jones prattled cheerily:
> On Sun, Apr 23, 2006 at 03:39:23PM -0400, Fernando Barsoba wrote:
>  > Adrian,
>  > 
>  > Thanks a lot for your answer. I am trying to install it on fedora 5. I 
>  > guess i should ask fedora forum about this matter.
> 
> Give up now.  There's no static /dev, no 2.4 compatible modutils,
> and a slew of other bits of userspace will be too new.

A rather more important piece is 2.6-only, IIRC: glibc!

-- 
`On a scale of 1-10, X's "brokenness rating" is 1.1, but that's only
 because bringing Windows into the picture rescaled "brokenness" by
 a factor of 10.' --- Peter da Silva
