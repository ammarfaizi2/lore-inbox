Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316383AbSEOOyX>; Wed, 15 May 2002 10:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316385AbSEOOyW>; Wed, 15 May 2002 10:54:22 -0400
Received: from ghost.liquidsteel.net ([62.8.161.162]:33698 "EHLO
	server.tevox.de") by vger.kernel.org with ESMTP id <S316383AbSEOOyV>;
	Wed, 15 May 2002 10:54:21 -0400
Date: Wed, 15 May 2002 16:54:18 +0200
From: Lars Weitze (Tevox GmbH) <lars.weitze@tevox.de>
To: linux-kernel@vger.kernel.org
Subject: Broken realtimeclock on Dual Xeon ?
Message-Id: <20020515165418.194b08a4.lars.weitze@tevox.de>
Organization: http://www.tevox.de
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: MaZxXNmAPP~K)WY;upHIIVxl>:X"k0ERjHtO}zN_c{ZT3pT^vzA1@Z'gv)IT79t02mY&"iK ppH--FaAb"5b5`rlWTY3ltB~,vHIl1=@S]';RE7:63r+"(\PV~rW]bm5C'Z(wHEYM/<Hv`ov|%6pV` 0*.^/Y$V/
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Its's a dual 2.2 Ghz Intel Xeon running kernel 2.4.18.

When pingin (also other hostst) im am getting this strange messages:

holodeck-5:~# ping localhost -f
PING holodeck-5 (127.0.0.1) from 127.0.0.1 : 56(84) bytes of data.
.Warning: time of day goes back (-2678194us), taking countermeasures.
Warning: time of day goes back (-2678085us), taking countermeasures.
.Warning: time of day goes back (-2678177us), taking countermeasures.
.Warning: time of day goes back (-2678179us), taking countermeasures.
.Warning: time of day goes back (-2678180us), taking countermeasures.
.Warning: time of day goes back (-2678179us), taking countermeasures.
.Warning: time of day goes back (-2678179us), taking countermeasures.
.Warning: time of day goes back (-2678178us), taking countermeasures.
. 
--- holodeck-5 ping statistics ---




-- 
TEVOX GmbH
Neusserstr.772
D-50737 Cologne
Germany
Voice: +49 (22 1) 974 524 70
Fax:   +49 (22 1) 974 524 44
