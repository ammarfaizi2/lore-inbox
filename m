Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264529AbRFJOJA>; Sun, 10 Jun 2001 10:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264530AbRFJOIu>; Sun, 10 Jun 2001 10:08:50 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:50703 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S264529AbRFJOIk>;
	Sun, 10 Jun 2001 10:08:40 -0400
Date: Sun, 10 Jun 2001 10:09:35 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Cc: maxk@qualcomm.com
Subject: Undocumented configuration symbols in 2.4.6pre2
Message-ID: <20010610100935.A11098@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net, maxk@qualcomm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.4.6-pre2 kernel introduces some new configuration symbols:

CONFIG_AMD7409_OVERRIDE
CONFIG_BLK_DEV_AMD7409
CONFIG_BLK_DEV_OSB4
CONFIG_BLUEZ
CONFIG_BLUEZ_HCIEMU
CONFIG_BLUEZ_HCIUART
CONFIG_BLUEZ_HCIUSB
CONFIG_BLUEZ_L2CAP

Would the people responsible for these symbols please write Configure.help
entries and send them to me?  Before this update Configure.help had 
complete coverage; let's try to keep it that way.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"Today, we need a nation of Minutemen, citizens who are not only prepared to
take arms, but citizens who regard the preservation of freedom as the basic
purpose of their daily life and who are willing to consciously work and
sacrifice for that freedom."	-- John F. Kennedy
