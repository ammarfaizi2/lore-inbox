Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261296AbRFNHen>; Thu, 14 Jun 2001 03:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261390AbRFNHei>; Thu, 14 Jun 2001 03:34:38 -0400
Received: from danielle.hinet.hr ([195.29.254.157]:48141 "EHLO
	danielle.hinet.hr") by vger.kernel.org with ESMTP
	id <S261296AbRFNHeG>; Thu, 14 Jun 2001 03:34:06 -0400
Date: Thu, 14 Jun 2001 09:34:05 +0200
From: Mario Mikocevic <mozgy@hinet.hr>
To: linux-kernel@vger.kernel.org
Subject: Need a helping hand (realproducer and radio device)
Message-ID: <20010614093405.C6467@danielle.hinet.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an Hauppauge WinTV/Radio card and I want to be able to use it's radio
device as a source for live broadcast.

It's RH71 distro updated with mainstream 2.4.5 .

Radio device works fine on it's own meaning that I can tune the station and
listen to it.

RealProducer (8.5) also works fine meaning that it encodes video inputs and Line-In
input into realmedia stream just fine.


The problem is that in startup realproducer mutes (IMO) or shuts down or something, that radio
device on bt8x8 card and therefore no actual audio signal gets to Line-In resulting in no audio
in realmedia stream.


What can be done ?

 unfortunately, changing hardware is not a strong option for me

 everything like kernel/driver/userspace_utils patches is welcome

 I'll gladly accept even library hacks :)

 even a pointer to documentation _how_ it can be done is appreciated
  (I'll try doing programming myself then :)


TIA,

-- 
Mario Mikoèeviæ (Mozgy)
My favourite FUBAR ...
