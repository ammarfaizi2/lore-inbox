Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289091AbSANWTO>; Mon, 14 Jan 2002 17:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289098AbSANWTF>; Mon, 14 Jan 2002 17:19:05 -0500
Received: from ns.suse.de ([213.95.15.193]:56073 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289094AbSANWTA>;
	Mon, 14 Jan 2002 17:19:00 -0500
Date: Mon, 14 Jan 2002 23:18:55 +0100
From: Dave Jones <davej@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: esr@thyrsus.com, linux-kernel@vger.kernel.org
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Message-ID: <20020114231855.A21353@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Jeff Garzik <jgarzik@mandrakesoft.com>, esr@thyrsus.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020114132618.G14747@thyrsus.com> <m16QCNJ-000OVeC@amadeus.home.nl> <20020114145035.E17522@thyrsus.com> <20020114213732.M15139@suse.de> <20020114153844.A20537@thyrsus.com> <3C4356A9.367BC989@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C4356A9.367BC989@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Jan 14, 2002 at 05:07:37PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 05:07:37PM -0500, Jeff Garzik wrote:
 > 
 > For network cards one needs only to issue the ETHTOOL_GDRVINFO ioctl to
 > find out what hardware is associated with an ethernet interface.

 but not all the net drivers support this yet do they?

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
