Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287007AbSAGUwV>; Mon, 7 Jan 2002 15:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287025AbSAGUwL>; Mon, 7 Jan 2002 15:52:11 -0500
Received: from ohiper1-215.apex.net ([209.250.47.230]:11792 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S287007AbSAGUv7>; Mon, 7 Jan 2002 15:51:59 -0500
Date: Mon, 7 Jan 2002 14:51:50 -0600
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [s-h] Re: ALSA patch for 2.5.2pre9 kernel
Message-ID: <20020107145150.A10143@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 2:33pm  up 42 days, 21:20,  1 user,  load average: 1.30, 1.26, 1.20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that if we do not keep all the ALSA stuff together under
linux/sound, I think we should at least refrain from cramming it in with
the OSS drivers in linux/drivers/sound.  Perhaps a linux/drivers/alsa
would be preferable?
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
Well, who's mad now?
			-- Montgomery C. Burns
