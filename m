Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270332AbTGRXXL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 19:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270385AbTGRXXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 19:23:11 -0400
Received: from host203.erdely.net ([207.224.14.203]:57472 "EHLO
	julius.localhost") by vger.kernel.org with ESMTP id S270332AbTGRXXJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 19:23:09 -0400
Subject: SIS7012 works but get's frozen
From: "P.I.Julius" <julius@solutions-i.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Solutions-i.org
Message-Id: <1058571456.3642.24.camel@julius>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 18 Jul 2003 19:37:36 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kernel hackers

I have a sis7012 sound card with my new laptop SonyVaio PCG-GRT100 but
the sound is not working. I tried out with the kernel i810_audio modul,
with the OpenSounSystem, and with the alsa too, but with every driver my
sound card is not working. The modules are loaded, and i can change the
volume with aumix, but if i try to play a sound file, just the first
second gets played, and then my box gets frozen.

Please help, i really want to hear more then 1 second from a mp3 file :)
Thanks a lot
Julius

-- 
:: solutions-i.org :: | your imagination + our solutions

