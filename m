Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316542AbSG1Rid>; Sun, 28 Jul 2002 13:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316614AbSG1Rid>; Sun, 28 Jul 2002 13:38:33 -0400
Received: from ua150d35hel.dial.kolumbus.fi ([62.248.233.150]:37129 "EHLO
	uworld.dyndns.org") by vger.kernel.org with ESMTP
	id <S316542AbSG1Ric>; Sun, 28 Jul 2002 13:38:32 -0400
Message-ID: <3D442CD3.89DA2E48@kolumbus.fi>
Date: Sun, 28 Jul 2002 20:41:39 +0300
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Ernst Lehmann <lehmann@acheron.franken.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problems with AMD 768 IDE support
References: <1027364446.26894.2.camel@hadley>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ernst Lehmann wrote:
> 
> I have here a Dual-Athlon Box, with a AMD760MPX Chipset and AMD768 IDE.
> In the base 2.4.18 kernel there seems to be no support for the
> IDE-Chipset

I have Tyan Tiger MPX (AMD768) working just fine with my patch set. However,
it currently has only single CPU. Patch is for 2.4.19-pre7.

http://uworld.dyndns.org/projects/linux/


	- Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers

