Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132565AbRCZTKX>; Mon, 26 Mar 2001 14:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132563AbRCZTKP>; Mon, 26 Mar 2001 14:10:15 -0500
Received: from [213.96.224.204] ([213.96.224.204]:6149 "HELO man.beta.es")
	by vger.kernel.org with SMTP id <S132562AbRCZTKF>;
	Mon, 26 Mar 2001 14:10:05 -0500
Date: Mon, 26 Mar 2001 21:08:46 +0200
From: Santiago Garcia Mantinan <manty@udc.es>
To: linux-kernel@vger.kernel.org
Subject: Problems with Wake on LAN
Message-ID: <20010326210846.A1182@manty.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've been trying to get Wake on LAN working under kernel 2.4.2 with a 3COM
3c905C-TX card, standard 2.4.2 drivers, I have manage to get it working, but
only if I don't compile ACPI and I don't load the network card driver, as
any of this things make the Wake on LAN not work. APM and other features
don't seem to affect the card waking, but this two really break it.

Is there any plan on solving any of this for the future?

Is there anything I can do to help get this working?

PS: cc me as I'm not on the list.

Regards..
-- 
Manty/BestiaTester -> http://manty.net
