Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287098AbRL2Ckv>; Fri, 28 Dec 2001 21:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287102AbRL2Ckb>; Fri, 28 Dec 2001 21:40:31 -0500
Received: from sushi.toad.net ([162.33.130.105]:28877 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S287101AbRL2Ck3>;
	Fri, 28 Dec 2001 21:40:29 -0500
Subject: PnP BIOS driver ready to go in
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 28 Dec 2001 21:40:42 -0500
Message-Id: <1009593644.9510.2.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo:  I have had no reports of problems with the PnP BIOS
driver, so I believe it can go in.  You can get it at:
   http://panopticon.csustan.edu/thood/pnpbios.html

Note that for now the driver is only to be used for system
configuration using the lspnp and setpnp utilities.  How to
interface this driver with other drivers is a matter that
may require further consideration.

Thanks
--
Thomas Hood

