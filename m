Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129903AbQKWThq>; Thu, 23 Nov 2000 14:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129091AbQKWThh>; Thu, 23 Nov 2000 14:37:37 -0500
Received: from porgy.srv.nld.sonera.net ([195.66.15.137]:3102 "EHLO
        porgy.srv.nld.sonera.net") by vger.kernel.org with ESMTP
        id <S129905AbQKWThY>; Thu, 23 Nov 2000 14:37:24 -0500
Message-ID: <3A1D6AE1.60DF0AAD@ITS.TUDelft.nl>
Date: Thu, 23 Nov 2000 20:07:13 +0100
From: "H.J.Visser" <H.J.Visser@ITS.TUDelft.nl>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-21mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Power-off doesn't work in 2.4.0test11
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since I use kernel 2.4.0(test11) the power-off on halt doesn't work 
anymore (I have the same problem with previous 2.4.0 releases).

I use apm to power-off the system (my system doesn't support acpi) and 
with kernel 2.2.17 everything works great. But since I've compiled 
2.4.0test11 with exactly the same configuration, my system doesn't 
power-off anymore.

I use a celeron 266@400MHz with a BX-pro mainboard with an ALi chipset.

Does anyone know how I get my system to power-off again?

Thanx,
Jeroen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
