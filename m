Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbTK3WkH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 17:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTK3WkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 17:40:07 -0500
Received: from hell.sks3.muni.cz ([147.251.210.31]:40890 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S261569AbTK3WkE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 17:40:04 -0500
Date: Sun, 30 Nov 2003 23:39:53 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Synaptics PS/2 driver and 2.6.0-test11
Message-ID: <20031130223953.GR2935@mail.muni.cz>
References: <20031130214612.GP2935@mail.muni.cz> <200311301728.10563.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200311301728.10563.dtor_core@ameritech.net>
X-Muni: zakazka, vydelek, firma, komerce, vyplata
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, Mossad, Iraq, Pentagon, WTC, president, assassination, A-bomb, kua, vic joudu uz neznam
X-policie-CR: Neserte mi nebo ukradnu, vyloupim, vybouchnu, znasilnim, zabiju, podpalim, umucim, podriznu, zapichnu a vubec vsechno
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 05:28:10PM -0500, Dmitry Torokhov wrote:
> Are you using ACPI? Does it work without ACPI? Do you have an application
> that periodically polls battery state or temperature? From what I've seen
> many laptops spend considerable amount of time in BIOS when checking
> battery state...

I'm using ACPI both in 2.4.22 and 2.6.0. I'm using battery_applet (gnome applet)
for testing battery state.

I will try it. Is acpi=off at boot time enough for that?

-- 
Luká¹ Hejtmánek
