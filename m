Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161045AbWHJFyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161045AbWHJFyr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 01:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161046AbWHJFyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 01:54:46 -0400
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:37067 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1161045AbWHJFyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 01:54:46 -0400
Message-ID: <44DACA22.6090701@comcast.net>
Date: Thu, 10 Aug 2006 01:54:42 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: How does Linux do RTTM?
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

How does Linux do RFC 1323 style RTTM measurement?  Is there a
pseudo-clock used i.e. number of jiffies since boot?  Or just a
real-time timestamp?

Sorry for the dumb questions but Google is being massively bad at "tell
me about an obscure feature of the Linux kernel that nobody cares about"
today :)

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRNrKHws1xW0HCTEFAQL/kA//YKZ+lFWk1XUHTfQUCLClvBEsope7KYDg
8POJjpJVRhOf5ckexPXvmBbxnXJBB4zki2JRiiEbaHtHkMncdk8Ts7r/2Au8YGEj
Jo0ahOssvQKPm3WBeZgXrOXjdRYuF2fW03wrBAuKL3KqXV8U2v4gFcWzV6pysBBp
4gYevF6DS4MXX6Loo9o/HowC4UFZgktELkDE6NX6gMh4aXNwhtsReOlfxY2to2yd
A2R89iJjWvPr3UeG6gpej7GOCg9XuW0nwfMJ5V4T5OqSDVbB0feXBCTEC8JtxPwD
Quc6UTv4Vqx3+lTS71YeTjE2/Oyi77eW46ycnsjPgeQ9mH67ZWA7GYgDxSqvfpbz
9Dn4+elboMKwPXD7FmlC4CjrtsyeB7ebqfUOTRRd4M2IqFZ2y2t50m3TgAAoe3vR
h62RN1o425QSRQlEje7De7ST2jG9UdaNceYt9TT0QZBRsN44TUT+6p1YoFVs6uU0
IhGu+zsFmltE7DuVu9CxWJQ70LP9L/qCWllyPOdGobbDyYISw047sDrxPjF8N5ha
j+I40ozs2JG5Jg3d0w5DDYPsSfeh/LLlLzyGEQzwzXr5PZJaJVeEtb/jroqhjvXc
PAegzN0DUnWVoMX0/Uv6oLoWIYsgwcTLw6ieCeOt5ljTpJxeaJtrcl3RPipLbKrF
HgPtUNRGjqk=
=5z5t
-----END PGP SIGNATURE-----
