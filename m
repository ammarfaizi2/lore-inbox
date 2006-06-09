Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbWFIJok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbWFIJok (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 05:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWFIJok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 05:44:40 -0400
Received: from insecure.ws ([82.231.161.45]:43918 "EHLO insecure.ws")
	by vger.kernel.org with ESMTP id S964896AbWFIJok (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 05:44:40 -0400
Message-ID: <44894309.8050602@insecure.ws>
Date: Fri, 09 Jun 2006 11:44:41 +0200
From: kang <kang@insecure.ws>
User-Agent: Thunderbird 1.5.0.2 (X11/20060505)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RSBAC 1.2.7 Released
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The RSBAC team is happy to announce that RSBAC 1.2.7  has just been
released for both kernels 2.4.32 and 2.6.16.
This is the latest stable version. There is no special upgrade path if
you were using 1.2.6 or 1.2.5
Simply compile, install the new admin tools and the new kernel.

This is a short release since 1.2.6 that fixes a few remaining issues.

Changes since 1.2.6:

  * Fix rsbac-admin debian Changelog
  * Fix 2.4 pax flags location
  * Fix 1.2.6 patches issues (non-RSBAC code)

Changes since 1.2.5:

  * New kthread notification code
  * rsbac_login behaving now more like pam login
  * GCC-4 compatibility fixes
  * Change FF to allow file READ (but not READ_OPEN) even with
execute_only
  * Caches infected scan results on read/open/close instead of rescan
  * xstats now include GROUP targets
  * Debian package fixes


Patches and prepatched kernels are available at this location:

http://rsbac.org/download#current_version1.2.7
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEiUMI80VHuunDdyYRAkZjAJ9G+BfTUpHI+Q8YRI27YSr8qHKPVACgnVB6
V+y/CROUHqOOrjMa2vyg9uk=
=qA2s
-----END PGP SIGNATURE-----

