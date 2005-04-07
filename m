Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262314AbVDGIfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbVDGIfR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 04:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbVDGIe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 04:34:27 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:22281 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S262365AbVDGIcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 04:32:07 -0400
Date: Thu, 7 Apr 2005 10:32:05 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: David Schmitt <david@black.co.at>, debian-kernel@lists.debian.org,
       Jes Sorensen <jes@wildopensource.com>, Matthew Wilcox <matthew@wil.cx>,
       Greg KH <greg@kroah.com>, Sven Luther <sven.luther@wanadoo.fr>,
       Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
       linux-kernel@vger.kernel.org, linux-acenic@sunsite.dk
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050407083205.GA74679@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Xavier Bestel <xavier.bestel@free.fr>,
	David Schmitt <david@black.co.at>, debian-kernel@lists.debian.org,
	Jes Sorensen <jes@wildopensource.com>,
	Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>,
	Sven Luther <sven.luther@wanadoo.fr>,
	Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
	linux-kernel@vger.kernel.org, linux-acenic@sunsite.dk
References: <20050404100929.GA23921@pegasos> <20050404183909.GI18349@parcelfarce.linux.theplanet.co.uk> <yq08y3vxd3x.fsf@jaguar.mkp.net> <200504071004.32692@zion.black.co.at> <1112861835.8281.204.camel@gonzales>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1112861835.8281.204.camel@gonzales>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 10:17:15AM +0200, Xavier Bestel wrote:
> Le jeudi 07 avril 2005 à 10:04 +0200, David Schmitt a écrit :
> 
> > Then I would like to exercise my right under the GPL to aquire the source code 
> > for the firmware (and the required compilers, starting with genfw.c which is 
> > mentioned in acenic_firmware.h) since - as far as I know - firmware is coded 
> > today in VHDL, C or some assembler and the days of hexcoding are long gone.
> 
> VHDL is a hardware description language. You don't code firmware in
> VHDL.

If the firmware, or part of it, is uploaded to a fpga you do (or
Verilog instead of VHDL, same difference).

  OG.
