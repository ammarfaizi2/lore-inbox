Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280845AbRKOO3Y>; Thu, 15 Nov 2001 09:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280848AbRKOO3E>; Thu, 15 Nov 2001 09:29:04 -0500
Received: from elin.scali.no ([62.70.89.10]:5389 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S280845AbRKOO3A>;
	Thu, 15 Nov 2001 09:29:00 -0500
Subject: Watchdogs dynamically setting NOWAYOUT
From: Terje Eggestad <terje.eggestad@scali.no>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 15 Nov 2001 15:28:59 +0100
Message-Id: <1005834539.1301.20.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Do anyone have a patch that allows setting the compile time flag 
CONFIG_WATCHDOG_NOWAYOUT dynamically, like thru /proc ??

It would be nice during maintance to disable automatic reboot.

TJ

-- 
_________________________________________________________________________

Terje Eggestad                  terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 70 Bogerud                      +47 975 31 574  (MOBILE)
N-0621 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

