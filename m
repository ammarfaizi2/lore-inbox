Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264352AbRGCNGQ>; Tue, 3 Jul 2001 09:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264381AbRGCNGG>; Tue, 3 Jul 2001 09:06:06 -0400
Received: from wh58-709.st.Uni-Magdeburg.DE ([141.44.198.79]:12292 "HELO
	wh58-709.st.uni-magdeburg.de") by vger.kernel.org with SMTP
	id <S264352AbRGCNFu>; Tue, 3 Jul 2001 09:05:50 -0400
Date: Tue, 3 Jul 2001 15:05:58 +0200 (CEST)
From: Erik Meusel <erik@wh58-709.st.uni-magdeburg.de>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: include/asm-i386/checksum.h 
In-Reply-To: <2487.994146067@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.33.0107031504190.21597-200000@wh58-709.st.uni-magdeburg.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="747458502-732379838-994165558=:21597"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--747458502-732379838-994165558=:21597
Content-Type: TEXT/PLAIN; charset=US-ASCII

And the same thing again, this time with include/asm-i386/floppy.h.
Patch is attached. I'm sorry to send this bit by bit, but I don't have the
time to do it all in one right now ;)

mfg, Erik

--747458502-732379838-994165558=:21597
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="floppy.h.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0107031505580.21597@wh58-709.st.uni-magdeburg.de>
Content-Description: 
Content-Disposition: attachment; filename="floppy.h.diff"

LS0tIC90bXAvbGludXgvaW5jbHVkZS9hc20taTM4Ni9mbG9wcHkuaAlTYXQg
TWF5IDI2IDAzOjAxOjM4IDIwMDENCisrKyBpbmNsdWRlL2FzbS9mbG9wcHku
aAlUdWUgSnVsICAzIDE0OjM3OjQwIDIwMDENCkBAIC03OCwyMSArNzgsMjEg
QEANCi0gICAgICAgInRlc3RsICUxLCUxDQotCWplIDNmDQotMToJaW5iICV3
NCwlYjANCi0JYW5kYiAkMTYwLCViMA0KLQljbXBiICQxNjAsJWIwDQotCWpu
ZSAyZg0KLQlpbmN3ICV3NA0KLQl0ZXN0bCAlMywlMw0KLQlqbmUgNGYNCi0J
aW5iICV3NCwlYjANCi0JbW92YiAlMCwoJTIpDQotCWptcCA1Zg0KLTQ6ICAg
ICAJbW92YiAoJTIpLCUwDQotCW91dGIgJWIwLCV3NA0KLTU6CWRlY3cgJXc0
DQotCW91dGIgJTAsJDB4ODANCi0JZGVjbCAlMQ0KLQlpbmNsICUyDQotCXRl
c3RsICUxLCUxDQotCWpuZSAxYg0KLTM6CWluYiAldzQsJWIwDQorICAgICAg
ICJ0ZXN0bCAlMSwlMSBcDQorCWplIDNmIFwNCisxOglpbmIgJXc0LCViMCBc
DQorCWFuZGIgJDE2MCwlYjAgXA0KKwljbXBiICQxNjAsJWIwIFwNCisJam5l
IDJmIFwNCisJaW5jdyAldzQgXA0KKwl0ZXN0bCAlMywlMyBcDQorCWpuZSA0
ZiBcDQorCWluYiAldzQsJWIwIFwNCisJbW92YiAlMCwoJTIpIFwNCisJam1w
IDVmIFwNCis0OiAgICAgCW1vdmIgKCUyKSwlMCBcDQorCW91dGIgJWIwLCV3
NCBcDQorNToJZGVjdyAldzQgXA0KKwlvdXRiICUwLCQweDgwIFwNCisJZGVj
bCAlMSBcDQorCWluY2wgJTIgXA0KKwl0ZXN0bCAlMSwlMSBcDQorCWpuZSAx
YiBcDQorMzoJaW5iICV3NCwlYjAgXA0K
--747458502-732379838-994165558=:21597--
