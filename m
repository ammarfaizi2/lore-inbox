Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbTBSSun>; Wed, 19 Feb 2003 13:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261645AbTBSSun>; Wed, 19 Feb 2003 13:50:43 -0500
Received: from barclay.balt.net ([195.14.162.78]:35047 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id <S261593AbTBSSum>;
	Wed, 19 Feb 2003 13:50:42 -0500
Date: Wed, 19 Feb 2003 20:50:17 +0200
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.62
Message-ID: <20030219185017.GA6091@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
References: <Pine.LNX.4.44.0302171515110.1150-100000@penguin.transmeta.com> <3E536237.8010502@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E536237.8010502@blue-labs.org>
User-Agent: Mutt/1.4i
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2003 at 05:53:43AM -0500, David Ford wrote:
> 2.5.60+ is rather unstable for me on an Athlon CPU w/ gcc 3.2.2.  If I'm 
> careful and do very little in X, it seems to stay up for a few days.  If 
> I do any sort of fast graphics or sound, etc, it'll die very quickly.  
> 'tis an instant death with no OOPS, nothing at all on screen, nothing on 
> serial console.
> 
> Just an FYI, I'm trying to narrow it down.

it might triple fault ? Who knows. One thing I am sure of, if I don't
load agpgart + intel-agp, laptop in questions, works flawlessly.
Otherwise first time I log of KDE trying to login as different user I
get instant reboot.

That's the clue.

ps.
Hardware :

Compaq EVO 800
Intel P4, 1.7GHz, 256MB RAM, ATI Radeon Mobility LY (something).

> 
> David
