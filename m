Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293352AbSBYSDi>; Mon, 25 Feb 2002 13:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293298AbSBYSDS>; Mon, 25 Feb 2002 13:03:18 -0500
Received: from [62.98.190.136] ([62.98.190.136]:11648 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S293219AbSBYSDR> convert rfc822-to-8bit; Mon, 25 Feb 2002 13:03:17 -0500
Message-Id: <200202251902.g1PJ2AY02534@localhost.localdomain>
Content-Type: text/plain;
  charset="iso-8859-15"
From: Guido Volpi <lugburz@tiscalinet.it>
To: linux-kernel@vger.kernel.org
Subject: nvidia tnt2 and kernel 2.4.18-rc4
Date: Mon, 25 Feb 2002 19:02:09 +0000
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel 2.4.18-rc4 seem have problems with nvidia tnt2. i have compiled with 
success this release on a: athlon xp 1700+ with 2.96 gcc compiler, hav an 
unresolved simbol on snd-rawmidi.o module of alsa-sound driver and afer then 
have installed NVdriver modules video in console freeze.
-- 
=============================================================================
	...
	E quando qualcuno mi dice che il lavoro è ecc. ecc.,
	come se fregasse rafano su una grattugia arruginita,
	io, con una mano sulla spalla, gli domando soavemente:
	«Voi chiedete ancora carte, quando avete un cinque?»

			Vladimir Majakovskij
		(Qualche buona parola per certi vizi)
=============================================================================
