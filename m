Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313322AbSC2AsE>; Thu, 28 Mar 2002 19:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313323AbSC2Arx>; Thu, 28 Mar 2002 19:47:53 -0500
Received: from 198.216-123-194-0.interbaun.com ([216.123.194.198]:3077 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S313322AbSC2Arl>; Thu, 28 Mar 2002 19:47:41 -0500
Date: Thu, 28 Mar 2002 17:47:24 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: tulip driver again
Message-ID: <20020328174724.A24374@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know that this is boring and a number of my earlier reports was
apparently ignored but a tulip driver "0.9.15-pre10 (Mar 8, 2002)"
as used in 2.4.19-pre4 still does not really work.  I know that it is
fine with various clones like "Davicom" and "Lite-On PNIC", for example,
but with a real tulip from DEC, PCI id 1011:0019, not a single ethernet
packet is getting through.

Luckily 'de4x5' allows me to use a network but maybe this "tulip" driver
should be renamed onto "anything-but-tulip"?

  Michal
