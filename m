Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264185AbTE0VZR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 17:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbTE0VZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 17:25:17 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:38851 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S264185AbTE0VZN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 17:25:13 -0400
Date: Tue, 27 May 2003 17:38:40 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: [PATCH] VIA IDE fix for 2.4.21-rc5
Message-ID: <Pine.LNX.4.55.0305271735180.13016@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-429917714-1054071520=:13016"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-429917714-1054071520=:13016
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi, Marcelo!

The last minute changes in 2.4.21-rc5 break VIA IDE compilation.  The
patch is attached.  The ID and the relative position of the entry in the
list have been taken from Linux 2.5.70.

-- 
Regards,
Pavel Roskin
--8323328-429917714-1054071520=:13016
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="via8237.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.55.0305271738400.13016@marabou.research.att.com>
Content-Description: 
Content-Disposition: attachment; filename="via8237.diff"

LS0tIGluY2x1ZGUvbGludXgvcGNpX2lkcy5oDQorKysgaW5jbHVkZS9saW51
eC9wY2lfaWRzLmgNCkBAIC0xMDMwLDYgKzEwMzAsNyBAQA0KICNkZWZpbmUg
UENJX0RFVklDRV9JRF9WSUFfODIzNSAgICAgICAgMHgzMTc3DQogI2RlZmlu
ZSBQQ0lfREVWSUNFX0lEX1ZJQV84Mzc3XzAgIDB4MzE4OQ0KICNkZWZpbmUg
UENJX0RFVklDRV9JRF9WSUFfODM3N18wCTB4MzE4OQ0KKyNkZWZpbmUgUENJ
X0RFVklDRV9JRF9WSUFfODIzNwkJMHgzMjI3DQogI2RlZmluZSBQQ0lfREVW
SUNFX0lEX1ZJQV84NkMxMDBBCTB4NjEwMA0KICNkZWZpbmUgUENJX0RFVklD
RV9JRF9WSUFfODIzMQkJMHg4MjMxDQogI2RlZmluZSBQQ0lfREVWSUNFX0lE
X1ZJQV84MjMxXzQJMHg4MjM1DQo=

--8323328-429917714-1054071520=:13016--
