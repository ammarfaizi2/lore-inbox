Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129184AbRCBODu>; Fri, 2 Mar 2001 09:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129172AbRCBODk>; Fri, 2 Mar 2001 09:03:40 -0500
Received: from deimos.ulpgc.es ([193.145.133.6]:58373 "HELO deimos.ulpgc.es")
	by vger.kernel.org with SMTP id <S129166AbRCBOD1>;
	Fri, 2 Mar 2001 09:03:27 -0500
Date: Fri, 2 Mar 2001 14:34:35 +0000 (WET)
From: Miguel Armas <kuko@ulpgc.es>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4.2 SMP + ATM hangs
Message-ID: <Pine.LNX.4.21.0103021349450.4667-100000@mento.ulpgc.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there!

We are having problems with a Compaq Proliant 1600 Server and a Fore 200E
ATM card using kernel 2.4.2. 
We have been using it for a long time with SMP enabled and everything
worked just fine (we didn't have ATM).
A couple days ago we installed a Fore 200E ATM card and after getting the
ATM address using ilmid the machine hangs. The kernel still respond to
pings, but the userspace is dead.

If we remove SMP support in the kernel everything works fine (but with
only one CPU)...

Salu2!
-- 
------------------------------------
Miguel Armas del Rio <kuko@ulpgc.es>
Division de Comunicaciones (DC)
Universidad de Las Palmas
------------------------------------



