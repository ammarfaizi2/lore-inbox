Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280594AbRKNOS4>; Wed, 14 Nov 2001 09:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280599AbRKNOSr>; Wed, 14 Nov 2001 09:18:47 -0500
Received: from elin.scali.no ([62.70.89.10]:13321 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S280594AbRKNOSa>;
	Wed, 14 Nov 2001 09:18:30 -0500
Subject: O_DIRECT broken in stock 2.4.13
From: Terje Eggestad <terje.eggestad@scali.no>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 14 Nov 2001 15:18:28 +0100
Message-Id: <1005747508.1310.3.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

open( , O_DIRECT) succeds, fcntl set and unset of the O_DIRECT flag is
ok, but I get buffered writes anyway. 

This works in 2.4.10 

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

