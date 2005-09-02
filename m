Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161100AbVIBWzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161100AbVIBWzT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 18:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161101AbVIBWzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 18:55:18 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:48041 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1161100AbVIBWzQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 18:55:16 -0400
Date: Sat, 3 Sep 2005 00:52:24 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: linux-kernel@vger.kernel.org
Cc: pascal.chapperon@wanadoo.fr, lars.vahlenberg@mandator.com,
       Alexey Dobriyan <adobriyan@gmail.com>, apatard@mandriva.com,
       jgarzik@pobox.com, akpm@osdl.org
Subject: sis190/sis191 driver
Message-ID: <20050902225224.GA25687@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A new patch-kit is available.

o Fix link event reporting (Arnaud Patard).

o Default to 10Mbps when nothing better can be detected (me).

o Experimental sis191 support + small rgmii changes.

Please report anything related to link management you are not satisfied
with. You can report success as well.

Testers for the sis191 part will be welcome too. I expect this part to
appear on recent (?) SiS 96x based motherboard. Please send a complete
lspci -vx if you own such a beast.

The patch-kit for 2.6.13 is available at the URLs below. If you are
working with a recent 2.6.13-git, you should start at sis190-170.patch
since anything else is already merged.

The patches against 2.6.13-git3 (hello Jeff) will be posted in the
upcoming messages in a few minutes.

Single file patch (for plain 2.6.13):
http://www.zoreil.com/~romieu/sis190/20050902-2.6.13-sis190-test.patch
 
Patch-kit (sic):
http://www.zoreil.com/~romieu/sis190/20050902-2.6.13/patches

Tarball (sic):
http://www.zoreil.com/~romieu/sis190/20050902-2.6.13.tar.bz2

--
Ueimor
