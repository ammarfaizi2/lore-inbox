Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129412AbQJaGon>; Tue, 31 Oct 2000 01:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129439AbQJaGoe>; Tue, 31 Oct 2000 01:44:34 -0500
Received: from fe4.rdc-kc.rr.com ([24.94.163.51]:53262 "EHLO mail4.kc.rr.com")
	by vger.kernel.org with ESMTP id <S129412AbQJaGo1>;
	Tue, 31 Oct 2000 01:44:27 -0500
To: subterfugue-announce@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] SUBTERFUGUE 0.1.99a (bugfix)
In-Reply-To: <m13qCYf-001qifC@microdog>
From: Mike Coleman <mcoleman2@kc.rr.com>
Date: 31 Oct 2000 00:44:25 -0600
In-Reply-To: mkc@users.sourceforge.net's message of "Mon, 30 Oct 2000 04:52:53 -0600 (CST)"
Message-ID: <878zr5fr1y.fsf@kc.net>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This mini-release just fixes a bug that could allow processes to escape
tracing under certain circumstances.  If you plan to make use of 'sf', you
should upgrade.

- --Mike


See http://subterfugue.org for info on SUBTERFUGUE.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.5 and Gnu Privacy Guard <http://www.gnupg.org/>

iD8DBQE5/mo0HxpYi0vMj/QRAmE6AJ9N/V57LZ6qUzYdSOsiAihqACQIEgCfVm7h
KShS58o2uzOWHyMUtUg5U9A=
=YKmp
-----END PGP SIGNATURE-----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
