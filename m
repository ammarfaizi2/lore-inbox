Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283916AbRLGKCy>; Fri, 7 Dec 2001 05:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284034AbRLGKCp>; Fri, 7 Dec 2001 05:02:45 -0500
Received: from cpe-66-1-134-68.ca.sprintbbd.net ([66.1.134.68]:26825 "HELO
	core.sitedirection.com") by vger.kernel.org with SMTP
	id <S283916AbRLGKCY>; Fri, 7 Dec 2001 05:02:24 -0500
Message-ID: <06f101c17f07$56673eb0$0f00a8c0@minniemouse>
From: "Jon" <marsaro@interearth.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <20011207093326.GA22128@accellion.com>
Subject: Re: Compaq Proliant DL360 + 2.4.1?-* eepro100 and e100 pause when inactive
Date: Fri, 7 Dec 2001 02:10:03 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Humm; I am also seeing eratic behaviour on the 2.4.12+ series using
eepro100. have you changed out the central point hub or switch? I did this
with a x-ovr and saw performance that should be expected under SuSE 2.4 16,
but still see issues under load with more than one target. Seems there are
differences for me under SuSE than RH, meaning the driver s compiled with
flags under SuSE or something that kills performance.


Regards,

Jon


----- Original Message -----
From: "Mathieu Legrand" <mathieu@accellion.com>
To: <linux-kernel@vger.kernel.org>
Sent: Friday, December 07, 2001 1:33 AM
Subject: Compaq Proliant DL360 + 2.4.1?-* eepro100 and e100 pause when
inactive



