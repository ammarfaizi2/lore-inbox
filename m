Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276680AbRJGUeH>; Sun, 7 Oct 2001 16:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276673AbRJGUd5>; Sun, 7 Oct 2001 16:33:57 -0400
Received: from akkar.interpost.no ([139.117.8.12]:59662 "EHLO
	akkar.interpost.no") by vger.kernel.org with ESMTP
	id <S276671AbRJGUdt>; Sun, 7 Oct 2001 16:33:49 -0400
Date: Sun, 7 Oct 2001 22:34:00 +0200
From: Roy-Magne Mo <rmo@sunnmore.net>
To: Willem Riede <wriede@home.com>
Cc: Steven Walter <srwalter@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Tyan Tiger MP AMD760 chipset support
Message-ID: <20011007223400.C8033@akkar.interpost.no>
In-Reply-To: <20011007132349.A1424@linnie.riede.org> <20011007141205.B4000@hapablap.dyn.dhs.org> <20011007153942.C1424@linnie.riede.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011007153942.C1424@linnie.riede.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2001 at 03:39:42PM -0400, Willem Riede wrote:
> That's not the issue, I'm not that ignorant. sensors-detect
> just doesn't find anything!

Upgrade to the cvs version of lm_sensors and the i2c drivers.

I can with these modules detect the eeprom, the AMD756 and the 
winbond W83782D.

But, however, inserting the winbond driver locks the computer hard. 

-- 
carpe noctem
