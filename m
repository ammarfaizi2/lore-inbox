Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbVCUPMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVCUPMZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 10:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVCUPMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 10:12:24 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:13544 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S261324AbVCUPJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 10:09:59 -0500
Date: Mon, 21 Mar 2005 16:09:54 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Luc Saillard <luc@saillard.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pwc driver in -mm kernels
Message-ID: <20050321150954.GD14614@gamma.logic.tuwien.ac.at>
References: <20050319130424.GB3316@gamma.logic.tuwien.ac.at> <1111416966.14877.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1111416966.14877.26.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mär 2005, Alan Cox wrote:
> I pushed the tested one as a starting point. May have been the wrong
> decision but it's my fault if so

Ah ok. I checked the differences between the versions but there are too
many `none-standard' changes, i.e. kernel-language changes (statics,
inlines, __) etc so that I cannot submit a patch for the new version.

The good thing about the one on Luc's page it that it includes sysfs
support for several parameters and some more device ids.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>                 Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
`We've got to find out what people want from fire, how
they relate to it, what sort of image it has for them.'
The crowd were tense. They were expecting something
wonderful from Ford.
`Stick it up your nose,' he said.
`Which is precisely the sort of thing we need to know,'
insisted the girl, `Do people want fire that can be fitted
nasally?'
                 --- Ford "debating" what to do with fire with a marketing
                 --- girl.
                 --- Douglas Adams, The Hitchhikers Guide to the Galaxy
