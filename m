Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312995AbSC0MAd>; Wed, 27 Mar 2002 07:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312996AbSC0MAX>; Wed, 27 Mar 2002 07:00:23 -0500
Received: from ns.suse.de ([213.95.15.193]:62737 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312995AbSC0MAL>;
	Wed, 27 Mar 2002 07:00:11 -0500
Date: Wed, 27 Mar 2002 13:00:08 +0100
From: Dave Jones <davej@suse.de>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] P4/Xeon Thermal LVT support
Message-ID: <20020327130008.D17832@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020327124333.A17832@suse.de> <Pine.LNX.4.44.0203271334060.31636-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2002 at 01:36:04PM +0200, Zwane Mwaikambo wrote:

 > That shouldn't be a problem since the interrupt only occurs on thermal 
 > transition, ie when you hit over the threshold or hit below. Therefore we 
 > shouldn't be fluctuating since the clock modulation will be in effect and 
 > the temperature will drop. However i can't be 100% certain.

Ok, I'll drop it into -dj2 and see if any P4 owning people scream 8)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
