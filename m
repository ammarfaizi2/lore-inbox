Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132147AbRDFRf1>; Fri, 6 Apr 2001 13:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132152AbRDFRfR>; Fri, 6 Apr 2001 13:35:17 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:53141 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132147AbRDFRfF>;
	Fri, 6 Apr 2001 13:35:05 -0400
Message-ID: <3ACDFE20.B278A681@mandrakesoft.com>
Date: Fri, 06 Apr 2001 13:34:24 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Johan Adolfsson <johan.adolfsson@axis.com>
Cc: Bernhard Bender <Bernhard.Bender@ELSA.de>, linux-kernel@vger.kernel.org
Subject: Re: ethernet phy link state info
In-Reply-To: <41256A26.005733A6.00@elsa.de> <1d7601c0beab$0cb2bfa0$0a070d0a@axis.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Adolfsson wrote:
> I don't have an answer but a related question:
> Is there any "standard ioctl" to force an interface
> to a certain link state, eg. auto, 10Mbs, 100Mbps,
> half/full duplex etc.?

/sbin/mii-tool should do this on most network cards.

-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
