Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274012AbRIXQk4>; Mon, 24 Sep 2001 12:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274002AbRIXQkk>; Mon, 24 Sep 2001 12:40:40 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:46730 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S274012AbRIXQkR>; Mon, 24 Sep 2001 12:40:17 -0400
Date: Mon, 24 Sep 2001 12:40:44 -0400
From: Arjan van de Ven <arjanv@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Binary only module overview
Message-ID: <20010924124044.B17377@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm composing a list of all existing binary only modules, 
and I got to a list of 26 different modules; I undoubtedly forgot a few, 
so I hereby request feedback from people who know about modules I
left out, so that I can complete the list. (I do not really care about
modules that once existed for 2.0 or earlier and no longer exist for all
intents and purposes)

Greetings,
  Arjan van de Ven


Hardware drivers
----------------
4-Front		- soundcard drivers
Adaptec		- Fiberchannel cards
Agilent		- Fiberchannel cards
aureal		- driver for soundcard
Conexant	- winmodem driver
Emulex		- Fiberchannel cards
Highpoint	- lowlevel IDE driver + software raid
IBM		- All hardware networkdrivers for S/390
Lucent		- driver for winmodem
Motorola	- driver for winmodem
M-Systems	- flash chips
NVidia		- 3D driver for their hardware 
Olicom		- tokenring networkcard
PCTel		- winmodem driver
Philips		- webcam driver
Promise		- lowlevel IDE driver + software raid
Sigma designs	- driver for soundcard

Highlevel drivers
-----------------
Cisco		- IPSEC
Hewlet Packard	- High level security modules (LSM)
Intel		- IPSEC 
Netraverse	- Win4lin
SGI		- XFS cluster extensions
		- High level security modules (LSM)
Sistina		- GFS and cluster extensions for LVM
Veritas		- Filesystem and Software RAID clusterextensions
Wirex		- High level security modules (LSM)



