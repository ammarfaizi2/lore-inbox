Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270619AbTGTEe5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 00:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270617AbTGTEe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 00:34:57 -0400
Received: from dialin-212-144-049-153.arcor-ip.net ([212.144.49.153]:24193
	"EHLO dd8ne.ampr.org") by vger.kernel.org with ESMTP
	id S270582AbTGTEez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 00:34:55 -0400
Message-ID: <3F1A1D25.8050108@privacy.net>
Date: Sun, 20 Jul 2003 06:40:05 +0200
From: Hans-Joachim Hetscher <me@privacy.net>
Reply-To: hajohe@imail.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-hams@vger.kernel.org
Subject: Problem with 6Pack using 2.5.xx Kernels
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I've a problem using the hamradio 6pack driver. Using the same 'setup'
for the initialisation as for the 2.4.20 kernel,... I've got the messages

Jul 19 07:56:48 dd8ne kernel: AX.25: 6pack driver, Revision: 0.3.0
Jul 19 07:56:48 dd8ne kernel: 6pack: TNC found.
Jul 19 07:56:48 dd8ne kernel: 6pack: resyncing TNC
Jul 19 07:56:48 dd8ne kernel: 6pack: TNC found.
Jul 19 07:56:48 dd8ne kernel: 6pack: resyncing TNC
Jul 19 07:56:48 dd8ne kernel: 6pack: TNC found.
Jul 19 07:56:48 dd8ne kernel: 6pack: resyncing TNC
Jul 19 07:56:48 dd8ne kernel: 6pack: TNC found.
Jul 19 07:56:48 dd8ne kernel: 6pack: resyncing TNC
Jul 19 07:56:48 dd8ne kernel: 6pack: TNC found.
Jul 19 07:56:48 dd8ne kernel: 6pack: resyncing TNC
Jul 19 07:56:48 dd8ne kernel: 6pack: TNC found.
..............

blowing up my syslog.

Vy 73

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/Gh0l3VQwVx4wircRAgJ0AJsENK12z2MJuo3R3Hv6+ePUoljjnwCeNOLX
GDu4K0+ZnGKlqwJN5gzalhU=
=BjZb
-----END PGP SIGNATURE-----

