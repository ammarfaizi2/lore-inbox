Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262958AbTJ3XJh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 18:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbTJ3XJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 18:09:37 -0500
Received: from savages.net ([12.154.202.18]:15526 "EHLO savages.net")
	by vger.kernel.org with ESMTP id S262958AbTJ3XJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 18:09:34 -0500
Message-ID: <3FA19A2A.3090500@savages.net>
Date: Thu, 30 Oct 2003 15:09:30 -0800
From: Shaun Savage <savages@savages.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netfilter@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: kernel modules won't auto load
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I am trying to get kernel 2.6-t9 working on redhat9

I have downloaded and compiled, and installed the kernel.
module-init-tools-0.9.15-pre2,
and iptables-1.2.9rc1

when I run iptables-restore it dies if I have not loaded the kernel
modules by hand before.


Thanks
Shaun
CC my address savages@hemp.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/oZooHrFvgoWMI60RAl0QAJ4/21BG/3+x0C7NaVP17tjvRacrpwCeI6FL
luoDLATHL13+cLnOxtBglJ0=
=B5rT
-----END PGP SIGNATURE-----

