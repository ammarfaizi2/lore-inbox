Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbULUQt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbULUQt7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 11:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbULUQt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 11:49:58 -0500
Received: from w130.z209220038.sjc-ca.dsl.cnc.net ([209.220.38.130]:3581 "EHLO
	mail.inostor.com") by vger.kernel.org with ESMTP id S261799AbULUQtB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 11:49:01 -0500
Message-ID: <41C852EE.90300@inostor.com>
Date: Tue, 21 Dec 2004 08:44:30 -0800
From: Tom Dickson <tdickson@inostor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: LVM2 on 2.4.28 kernel?
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I can apply the LVM2 patches from http://sources.redhat.com/dm/patches.html to the
2.4.28 kernel (it mentions things are off a bit).

I can also build device-mapper, but not using

./configure --with-kernel-dir

instead, I use

./configure

Is there anything else I should do? Has anyone else made it work? It seems like it
should work, but I don't want to switch over directly, if possible.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFByFLu2dxAfYNwANIRAmJ8AJ4zlslnP0kbCboWfSyzhluLbgiOFgCfRXL5
YU/aX0L6p/I6mpqZDB3dT2Y=
=lpFR
-----END PGP SIGNATURE-----
