Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUGBQu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUGBQu3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 12:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264723AbUGBQu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 12:50:29 -0400
Received: from hera.cwi.nl ([192.16.191.8]:52102 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264665AbUGBQu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 12:50:27 -0400
Date: Fri, 2 Jul 2004 18:50:13 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: "Patrick J. LoPresti" <patl@users.sourceforge.net>, bug-parted@gnu.org,
       "K.G." <k_guillaume@libertysurf.fr>,
       Steffen Winterfeldt <snwint@suse.de>, Thomas Fehr <fehr@suse.de>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Restoring HDIO_GETGEO semantics (was: Re: workaround for BIOS / CHS stuff)
Message-ID: <20040702165013.GB25914@apps.cwi.nl>
References: <s5gwu1mwpus.fsf@patl=users.sf.net> <Pine.LNX.4.21.0407021528150.21499-100000@mlf.linux.rulez.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0407021528150.21499-100000@mlf.linux.rulez.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 06:17:53PM +0200, Szakacsits Szabolcs wrote:

> Please also note, so far nobody stepped forward to fix parted.

Nobody asked, but I wouldnt mind fixing this particular
aspect of parted.

If nobody else wants to maintain it I can take it, but then
"maintain" means: zero development, just bugfixes.

Andries
