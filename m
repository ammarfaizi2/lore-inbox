Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314126AbSD0Nxq>; Sat, 27 Apr 2002 09:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314144AbSD0Nxn>; Sat, 27 Apr 2002 09:53:43 -0400
Received: from ns.suse.de ([213.95.15.193]:35602 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314195AbSD0Nwf>;
	Sat, 27 Apr 2002 09:52:35 -0400
Date: Sat, 27 Apr 2002 15:52:30 +0200
From: Dave Jones <davej@suse.de>
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.x-dj and SCSI error handling.
Message-ID: <20020427155230.J14743@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"Mr. James W. Laferriere" <babydr@baby-dragons.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020427131025.F14743@suse.de> <Pine.LNX.4.44.0204270947250.5500-100000@filesrv1.baby-dragons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2002 at 09:48:37AM -0400, Mr. James W. Laferriere wrote:
 > 	Hello Dave ,  Might be nice to also mention the drivers that were
 > 	being complained about .  So there respective mantainers can
 > 	benifit from your email .  Tia ,  JimL

noted. I'll do a full compile later today and post back the list of
drivers broken due to this issue. The only one everyone seems to be
complaining about is ide-scsi, but there are definitly others.

    Dave. 

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
