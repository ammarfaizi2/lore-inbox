Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266131AbSKFVnq>; Wed, 6 Nov 2002 16:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266133AbSKFVnp>; Wed, 6 Nov 2002 16:43:45 -0500
Received: from listserv1.openpolytechnic.ac.nz ([202.37.12.2]:43757 "EHLO
	mail1.openpolytechnic.ac.nz") by vger.kernel.org with ESMTP
	id <S266131AbSKFVno> convert rfc822-to-8bit; Wed, 6 Nov 2002 16:43:44 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Subject: setup.S unterminated #ifndef and gcc 3.3
Date: Thu, 7 Nov 2002 10:43:12 +1300
Message-ID: <4B2093FFC31B7A45862B62A376EA717601DDF7D2@mickey.topnz.ac.nz>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: setup.S unterminated #ifndef and gcc 3.3
Thread-Index: AcKF3YGoY+W4SYTkQICkvU3EGNs4Wg==
From: "Sartorelli, Kevin" <Kevin.Sartorelli@openpolytechnic.ac.nz>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is anyone else trying to use gcc 3.3 to compile the later kernels?  I'm using gcc 3.3 to try to compile 2.5.46 and get:

	arch/i386/boot/setup.S:298 unterminated #ifndef
	make[1]: *** [arch/i386/boot/setup.o] Error 1
	make: *** [bzImage] Error 2

I haven't seen anything on the list about this so am assuming that I'm either alone in trying this, or there is something not quite right with my configuration.

Any thoughts anyone (I know the one about using gcc 2.95.3 ;- ) )

Cheers
Kevin

