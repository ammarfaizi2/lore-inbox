Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265854AbTA2Mah>; Wed, 29 Jan 2003 07:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbTA2Mag>; Wed, 29 Jan 2003 07:30:36 -0500
Received: from ns.suse.de ([213.95.15.193]:36109 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265854AbTA2Mag>;
	Wed, 29 Jan 2003 07:30:36 -0500
Date: Wed, 29 Jan 2003 13:39:57 +0100
From: Dave Jones <davej@suse.de>
To: Craig Rodrigues <rodrigc@attbi.com>
Cc: zwane@commfireservices.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.59] sc1200wdt.c, isapnp_find_device -> pnp_find_device
Message-ID: <20030129133957.C1175@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Craig Rodrigues <rodrigc@attbi.com>, zwane@commfireservices.com,
	linux-kernel@vger.kernel.org
References: <20030129061951.GA8174@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030129061951.GA8174@attbi.com>; from rodrigc@attbi.com on Wed, Jan 29, 2003 at 01:19:51AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2003 at 01:19:51AM -0500, Craig Rodrigues wrote:

 > The following patch renames isapnp_find_device() to pnp_find_device(),
 > since isapnp_find_device() doesn't exist in the 2.5.59 kernel.

Adam Belay sent a more complete set of fixes on the 26th.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
