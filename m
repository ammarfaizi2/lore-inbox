Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSHBMNX>; Fri, 2 Aug 2002 08:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310190AbSHBMNX>; Fri, 2 Aug 2002 08:13:23 -0400
Received: from ns.suse.de ([213.95.15.193]:29967 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S293203AbSHBMNX>;
	Fri, 2 Aug 2002 08:13:23 -0400
Date: Fri, 2 Aug 2002 14:16:52 +0200
From: Dave Jones <davej@suse.de>
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: linux-2.5.30uc0 MMU-less patches
Message-ID: <20020802141652.E25761@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Greg Ungerer <gerg@snapgear.com>, linux-kernel@vger.kernel.org
References: <3D4A27FE.8030801@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D4A27FE.8030801@snapgear.com>; from gerg@snapgear.com on Fri, Aug 02, 2002 at 04:34:38PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2002 at 04:34:38PM +1000, Greg Ungerer wrote:
 > I have a new set of uClinux (MMU-less) patches for 2.5.30 at:
 > 
 >    http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/

One thing really puzzles me.
Why is there SGI VisWS, X86-foo, ACPI and god-knows-what-else
in arch/m68knommu/config.in ?

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
