Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293734AbSB1UyG>; Thu, 28 Feb 2002 15:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293732AbSB1UwO>; Thu, 28 Feb 2002 15:52:14 -0500
Received: from ns.suse.de ([213.95.15.193]:39696 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S293739AbSB1UrN>;
	Thu, 28 Feb 2002 15:47:13 -0500
Date: Thu, 28 Feb 2002 21:47:12 +0100
From: Dave Jones <davej@suse.de>
To: Nathan Walp <faceprint@faceprint.com>
Cc: Benjamin Pharr <ben@benpharr.com>, linux-kernel@vger.kernel.org,
        manfred@colorfullife.com
Subject: Re: Linux 2.5.5-dj1 - Bug Reports
Message-ID: <20020228214711.G32662@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Nathan Walp <faceprint@faceprint.com>,
	Benjamin Pharr <ben@benpharr.com>, linux-kernel@vger.kernel.org,
	manfred@colorfullife.com
In-Reply-To: <20020221233700.GA512@hst000004380um.kincannon.olemiss.edu> <20020222022149.N5583@suse.de> <20020222063721.GA8879@faceprint.com> <20020228165951.GA4014@faceprint.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020228165951.GA4014@faceprint.com>; from faceprint@faceprint.com on Thu, Feb 28, 2002 at 11:59:54AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > > Ditto here on my natsemi.  It hasn't really spit out the error since
 > > boot, about 12 hours ago.  Card has been mainly idle, only used to
 > > connect via crossover cable to my laptop, which hasn't been used much in
 > > that time.
 > 
 > dj2 is showing the same behavior, but I found out that the messages
 > continue to be printed 100 times/second until I ping-flooded the machine
 > on the other end of that card.  The minimal DHCP traffic prior to the
 > ping flood was not enough to make it stop.
 > 
 > Hope this helps narrow down the problem some.

 Yup, Manfred is aware of the problem, but hasn't had chance to
 look into it yet..  It'll be present at least until you see
 an entry in the changelog 8)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
