Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263684AbUCYXpH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 18:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263756AbUCYXpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 18:45:06 -0500
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:48296 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S263684AbUCYXo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:44:58 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: mdharm-usb@one-eyed-alien.net
Subject: 16K of junk at beginning of usb-storage device?
Date: Fri, 26 Mar 2004 00:44:30 +0100
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403260044.32404.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Matthew,

I have an Jenoptik JD 5200 z3 photo camera, which is supported by Linux.
Carsten Busse (who sent in the unusual_devs.h entry) has no problems with it.

I see 16K of junk at the beginning.

Is there a way to work around this somehow or should I claim firmware
error and send it back to the manufacturer?

Thanks & Regards

Ingo Oeser

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAY27eU56oYWuOrkARArTOAKCFkzK8+czTyGgCLVJ3Djpr/ah7oQCgo6jp
RwvH+1CSiHrOBhgH1JoQ5+A=
=pq5+
-----END PGP SIGNATURE-----
