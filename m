Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280628AbRKBJtS>; Fri, 2 Nov 2001 04:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280629AbRKBJtI>; Fri, 2 Nov 2001 04:49:08 -0500
Received: from stingr.net ([212.193.33.37]:18705 "HELO stingray.sgu.ru")
	by vger.kernel.org with SMTP id <S280628AbRKBJs4>;
	Fri, 2 Nov 2001 04:48:56 -0500
Date: Fri, 2 Nov 2001 12:48:32 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: linux-kernel@vger.kernel.org
Subject: error in cache-counting, or so
Message-ID: <20011102124832.W41175@stingr.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111020925560.32189-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111020925560.32189-100000@netfinity.realnet.co.sz>; from zwane@linux.realnet.co.sz on Fri, Nov 02, 2001 at 09:44:35AM +0200
User-Agent: Agent Orange
X-Mailer: mIRC32 v5.91 K.Mardam-Bey
X-RealName: Stingray Greatest Jr
Organization: Stingray Software
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

[stingray stingray]$ uname -a
Linux kg 2.4.13-ac5 #1 SMP Thu Nov 1 23:50:07 MSK 2001 i686 unknown
[stingray stingray]$ cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  129765376 23408640 106356736        0  9134080 18446744073706065920
Swap: 148013056        0 148013056
MemTotal:       126724 kB
MemFree:        103864 kB
MemShared:           0 kB
Buffers:          8920 kB
Cached:       4294963892 kB
SwapCached:          0 kB
Active:          14144 kB
Inact_dirty:       292 kB
Inact_clean:         0 kB
Inact_target:    26212 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       126724 kB
LowFree:        103864 kB
SwapTotal:      144544 kB
SwapFree:       144544 kB

need anything else ? .config etc. can be sent by req :)))
- -- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
-----BEGIN PGP SIGNATURE-----

iEYEAREDAAYFAjvia+0ACgkQyMW8naS07KS6WQCbBKSw6RAa35qgv7KkqPxWK5XD
9uAAoMn8ixhziC0jbtImM6y9LeKSTWz3
=m4kY
-----END PGP SIGNATURE-----
