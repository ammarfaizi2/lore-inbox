Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbTLPXmv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 18:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264383AbTLPXmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 18:42:42 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:36507 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264377AbTLPXmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 18:42:33 -0500
Date: Tue, 16 Dec 2003 23:42:07 +0000
From: Dave Jones <davej@redhat.com>
To: Xose Vazquez Perez <xose@wanadoo.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, pciids <pci-ids@ucw.cz>
Subject: Re: pciids commit
Message-ID: <20031216234207.GA26061@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Xose Vazquez Perez <xose@wanadoo.es>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	pciids <pci-ids@ucw.cz>
References: <3FDF973F.60309@wanadoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FDF973F.60309@wanadoo.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 17, 2003 at 12:37:35AM +0100, Xose Vazquez Perez wrote:
 > can any of these developers do a 'commit' of pciids ?
 > 
 > Dave Jones
 > Arjan van de Ven
 > Jeff Garzik
 > Lenz Grimmer
 > Martin Mares
 > Mike A. Harris
 > Bill Nottingham
 > Vojtech Pavlik
 > 
 > there is a lot of updates since 2003-08-12

Assuming you mean a sync between pciids.sf.net & kernel, this is
unlikely to happen until post 2.6.0.  Linus hasn't been taking
"this device wont work without this" type patches, which are IMHO
more important than ID updates, so I can't see him taking this either.

		Dave

