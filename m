Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbTK3Xkf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 18:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbTK3Xkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 18:40:35 -0500
Received: from hell.sks3.muni.cz ([147.251.210.31]:5828 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S261914AbTK3Xkd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 18:40:33 -0500
Date: Mon, 1 Dec 2003 00:40:19 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Synaptics PS/2 driver and 2.6.0-test11
Message-ID: <20031130234019.GU2935@mail.muni.cz>
References: <20031130214612.GP2935@mail.muni.cz> <200311301728.10563.dtor_core@ameritech.net> <20031130223953.GR2935@mail.muni.cz> <200311301826.52978.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200311301826.52978.dtor_core@ameritech.net>
X-Muni: zakazka, vydelek, firma, komerce, vyplata
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, Mossad, Iraq, Pentagon, WTC, president, assassination, A-bomb, kua, vic joudu uz neznam
X-policie-CR: Neserte mi nebo ukradnu, vyloupim, vybouchnu, znasilnim, zabiju, podpalim, umucim, podriznu, zapichnu a vubec vsechno
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 06:26:52PM -0500, Dmitry Torokhov wrote:
> How often does battery_applet poll the battery? Start with polling the
> battery less often, let's say every 3 minutes and see if the problem goes
> away.

Well as first approach I killed the battery applet and it looks like working ok.
When I run it again it immediatelly dump message about lost sync.

However why it does not do that with 2.4.22 kernel?

-- 
Luká¹ Hejtmánek
