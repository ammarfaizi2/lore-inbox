Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312465AbSDSOkv>; Fri, 19 Apr 2002 10:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312570AbSDSOku>; Fri, 19 Apr 2002 10:40:50 -0400
Received: from ns.suse.de ([213.95.15.193]:60686 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312465AbSDSOkt>;
	Fri, 19 Apr 2002 10:40:49 -0400
Date: Fri, 19 Apr 2002 16:40:48 +0200
From: Dave Jones <davej@suse.de>
To: Jan Slupski <jslupski@email.com>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: [PATCH] Wrong IRQ for USB on Sony Vaio (dmi_scan.c, pci-irq.c)
Message-ID: <20020419164048.H15517@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Jan Slupski <jslupski@email.com>, linux-kernel@vger.kernel.org,
	alan@redhat.com
In-Reply-To: <Pine.LNX.4.21.0204191553110.6667-100000@venus.ci.uw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2002 at 04:02:18PM +0200, Jan Slupski wrote:

 > Only problem is I don't have DMI Product names for all involved models.
 > That's why I left pretty general:
 >   MATCH(DMI_PRODUCT_NAME, "PCG-")

Too generic. This matches my Z600 for example, which does not have this bug.
 

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
