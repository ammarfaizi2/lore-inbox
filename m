Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292963AbSB0VsD>; Wed, 27 Feb 2002 16:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292839AbSB0VrW>; Wed, 27 Feb 2002 16:47:22 -0500
Received: from ns.suse.de ([213.95.15.193]:16393 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292963AbSB0VqR>;
	Wed, 27 Feb 2002 16:46:17 -0500
Date: Wed, 27 Feb 2002 22:46:15 +0100
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sean DETTRICK <dettrick@uci.edu>, linux-kernel@vger.kernel.org,
        support@asus.com, euro.cpu@amd.com
Subject: Re: A7M266-D, dual athlon 1800+ kernel-smp APIC boot problem workaround
Message-ID: <20020227224615.H16565@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Sean DETTRICK <dettrick@uci.edu>, linux-kernel@vger.kernel.org,
	support@asus.com, euro.cpu@amd.com
In-Reply-To: <Pine.GSO.4.44.0202271124590.22391-100000@e4e.oac.uci.edu> <E16gBRr-0005sg-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16gBRr-0005sg-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Feb 27, 2002 at 09:17:15PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 09:17:15PM +0000, Alan Cox wrote:

 > > BTW the Athlons, clearly marked in the boxes as MP, identified
 > > themselves as Athlon XP 1800+'s.   We thought this might be the
 > > problem at first but now we guess not.
 > 
 > The BIOS forgets to load the MP name string, like a load of other
 > problems it has. 

 x86info has proper descrimination of MP/XP using a readonly
 cpu-capability if theres any doubt here.
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
