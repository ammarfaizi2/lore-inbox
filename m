Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261383AbREUSqG>; Mon, 21 May 2001 14:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261377AbREUSp4>; Mon, 21 May 2001 14:45:56 -0400
Received: from erasmus.off.net ([64.39.30.25]:59914 "HELO erasmus.off.net")
	by vger.kernel.org with SMTP id <S261375AbREUSpx>;
	Mon, 21 May 2001 14:45:53 -0400
Date: Mon, 21 May 2001 14:45:54 -0400
From: Zach Brown <zab@zabbo.net>
To: Marcus Meissner <Marcus.Meissner@caldera.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: maestro ported to 2.4 PCI API
Message-ID: <20010521144554.C7003@erasmus.off.net>
In-Reply-To: <20010521173707.A10692@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010521173707.A10692@caldera.de>; from Marcus.Meissner@caldera.de on Mon, May 21, 2001 at 05:37:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	- ported to Linux 2.4 PCI API, PCI module based, cleaned up
> 	  return values. (taking into account all the hints Jeff has given
> 	  me ;)

cool :)

> 	- did NOT change any power management support, since I don't know
> 	  anything about power management.

someone else (in .de, it appears to be the source of maestro hacking
nowadays :)) is cleaning up the power management.

> 	- bumped version.

we might as well just stop using these, they don't mean much of anything
anymore.

- z
