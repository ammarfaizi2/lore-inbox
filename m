Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262482AbTCIIsk>; Sun, 9 Mar 2003 03:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262483AbTCIIsj>; Sun, 9 Mar 2003 03:48:39 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:51984 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262482AbTCIIsi>; Sun, 9 Mar 2003 03:48:38 -0500
Date: Sun, 9 Mar 2003 08:59:15 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Romain Lievin <roms@tilp.info>
Subject: Re: [PATCH] kconfig update
Message-ID: <20030309085915.A14548@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
	Romain Lievin <roms@tilp.info>
References: <Pine.LNX.4.44.0303090432200.32518-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0303090432200.32518-100000@serv>; from zippel@linux-m68k.org on Sun, Mar 09, 2003 at 04:57:54AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 09, 2003 at 04:57:54AM +0100, Roman Zippel wrote:
> Hi,
> 
> It took a bit longer than I wanted, but here is finally another kconfig 
> update. There are two important changes: I included Romain's gtk front 
> end and the support for the menuconfig keyword.

Any chance you could take a look at the patch that links lxdialog directly
to menuconfig instead of requiring the separate binary?  It has been
around for a long time and seems like a very worthwhile change, imho.

