Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280809AbRKORnq>; Thu, 15 Nov 2001 12:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280915AbRKORng>; Thu, 15 Nov 2001 12:43:36 -0500
Received: from pD952A6AE.dip.t-dialin.net ([217.82.166.174]:4480 "EHLO
	darkside.22.kls.lan") by vger.kernel.org with ESMTP
	id <S280809AbRKORna>; Thu, 15 Nov 2001 12:43:30 -0500
Date: Thu, 15 Nov 2001 18:43:22 +0100
From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
To: linux-kernel@vger.kernel.org
Subject: ACPI: kbd-pw-on/WOL doesn't work anymore with 2.4.14
Message-ID: <20011115184322.A625@darkside.ddts.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hoi,

since 2.4.14 kernel, after issuing 'halt', the Keyboard Power-ON or
Wake-On-LAN doesn't work anymore. I have to switch the machine on
with its Power Button.
With 2.4.13 kernel it works very well.

I'm using Asus P3B-F board with 440BX chipset.

Does ACPI use another State in Power Off since 2.4.14?

If so: How can I switch that back? - Preferred without an kernel
patch, maybe there is some config option like acpi_poweroff_state=Sx
or something like that?


PS: I'm not member on the linux-kernel@ list, so please CC me in
    replies, thanks.


regards,
   Mario
-- 
*axiom* welcher sensorische input bewirkte die output-aktion,
        den irc-chatter mit dem nick "dus" des irc-servers
        mittels eines kills zu verweisen?
