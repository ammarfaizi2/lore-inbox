Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310204AbSCABOH>; Thu, 28 Feb 2002 20:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310295AbSCABKp>; Thu, 28 Feb 2002 20:10:45 -0500
Received: from ns.suse.de ([213.95.15.193]:58120 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310284AbSCABHY>;
	Thu, 28 Feb 2002 20:07:24 -0500
Date: Fri, 1 Mar 2002 02:03:28 +0100
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Dennis Jim <jdennis@snapserver.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Congrats Marcelo,
Message-ID: <20020301020328.A7662@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Dennis Jim <jdennis@snapserver.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0203010137090.8089-100000@Appserv.suse.de> <E16gbbh-0001tN-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16gbbh-0001tN-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Mar 01, 2002 at 01:13:09AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 01:13:09AM +0000, Alan Cox wrote:
 > DMI can help in a much more productive way. DMI tells you the type of 
 > sensor in the machine. Once you are using ACPI though you talk to ACPI
 > and it talks to the smbus etc and knows whats in the box

 Given the fears of what happens when you look at i2c/smbus etc
 the wrong way, is this something we can rely on DMI tables
 to get right ?  When they can't get cachesize info right, I begin
 to question their ability to describe a temperature sensor.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
