Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273948AbRIRVsv>; Tue, 18 Sep 2001 17:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273950AbRIRVsl>; Tue, 18 Sep 2001 17:48:41 -0400
Received: from 203-79-66-98.adsl-wns.paradise.net.nz ([203.79.66.98]:11137
	"HELO volcano.kiwa.co.nz") by vger.kernel.org with SMTP
	id <S273948AbRIRVsd>; Tue, 18 Sep 2001 17:48:33 -0400
Date: Wed, 19 Sep 2001 09:48:53 +1200
From: Nicholas Lee <nj.lee@plumtree.co.nz>
To: Tim Moore <timothymoore@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Still flaky (Re: Crashing with Abit KT7, 2.2.19+ide patches)
Message-ID: <20010919094853.H550@inktiger.kiwa.co.nz>
Mail-Followup-To: Nicholas Lee <nj.lee@plumtree.co.nz>,
	Tim Moore <timothymoore@bigfoot.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010828155108.G14714@cone.kiwa.co.nz> <Pine.LNX.4.10.10108280029480.19311-100000@coffee.psychology.mcmaster.ca> <20010831103932.A30535@cone.kiwa.co.nz> <3B8ED3E5.22D6233@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B8ED3E5.22D6233@bigfoot.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2001 at 05:01:41PM -0700, Tim Moore wrote:
> I'd try another [non-seagate] disk before chasing ghosts.  The ide
> patch/2.2.19/.20 combo has been very stable.  Same tulip driver and VIA
> chipset.

System started reseting the IDE bus everyday, requiring a hard-power
reboot. Finally crash and corrupted /dev and /lib.

Replaced the Seagate HDD with a Fujitsu and removed the CDROM.  Seems to be fine now.


Thanks for the help.

Nicholas

