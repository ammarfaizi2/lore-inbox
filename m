Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbULHT4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbULHT4p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 14:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbULHT4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 14:56:45 -0500
Received: from w130.z209220038.sjc-ca.dsl.cnc.net ([209.220.38.130]:2547 "EHLO
	mail.inostor.com") by vger.kernel.org with ESMTP id S261340AbULHT4j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 14:56:39 -0500
Message-ID: <41B75BBF.8070004@inostor.com>
Date: Wed, 08 Dec 2004 11:53:35 -0800
From: Tom Dickson <tdickson@inostor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel Panic removing psnap or p8022 module in 2.4.28
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've attached the config file used to compile the vanilla 2.4.28 kernel
that produces the following panic:

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBt1u/2dxAfYNwANIRAnv/AJ4ugdX1btB8jpV42hzDzRSBb7IHFwCdEFBk
ZJBG04V2+KKCW16/CDFUKis=
=92+9
-----END PGP SIGNATURE-----
