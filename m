Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264838AbUEFAYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264838AbUEFAYI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 20:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264842AbUEFAYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 20:24:08 -0400
Received: from ce.fis.unam.mx ([132.248.33.1]:55959 "EHLO ce.fis.unam.mx")
	by vger.kernel.org with ESMTP id S264838AbUEFAYF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 20:24:05 -0400
From: Max Valdez <maxvalde@fis.unam.mx>
Organization: CCF
To: linux-kernel@vger.kernel.org
Subject: /bin/sync "sync - flush filesystem buffers"
Date: Wed, 5 May 2004 19:23:40 -0500
User-Agent: KMail/1.6.51
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200405051923.46404.maxvalde@fis.unam.mx>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all

Does "sync" commando actually works on newer kernels ??

I dont have the knowledge to figure it out by myself, but I suspect that this 
commando no longer works in newer File Systems, specially journaled ones,

am I totally wrong ??

Max
- -- 
Linux garaged 2.6.5-rc2-mm3 #1 Fri Mar 26 11:07:16 CST 2004 i686 Intel(R) 
Pentium(R) 4 CPU 2.80GHz GenuineIntel GNU/Linux
- -----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GS/S d- s: a-29 C++(+++) ULAHI+++ P+ L++>+++ E--- W++ N* o-- K- w++++ O- M-- 
V-- PS+ PE Y-- PGP++ t- 5- X+ R tv++ b+ DI+++ D- G++ e++ h+ r+ z**
- ------END GEEK CODE BLOCK------
gpg-key: http://garaged.homeip.net/gpg-key.txt
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAmYWMNNkpVEFxW78RAgyPAJ9uUP4AwWULdOR4QCEfN5+dMuDBjACeO6jh
NMKqsreQL4hlPjo5z5aDO3g=
=tcL4
-----END PGP SIGNATURE-----
