Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135573AbRDXMkQ>; Tue, 24 Apr 2001 08:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135574AbRDXMkH>; Tue, 24 Apr 2001 08:40:07 -0400
Received: from t2.redhat.com ([199.183.24.243]:49394 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S135573AbRDXMj4>; Tue, 24 Apr 2001 08:39:56 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010424095304.A2389@flint.arm.linux.org.uk> 
In-Reply-To: <20010424095304.A2389@flint.arm.linux.org.uk>  <200104232232.AAA12700@kufel.dom> <Pine.LNX.4.33.0104232349530.15177-100000@imladris.demon.co.uk> 
To: Russell King <rmk@arm.linux.org.uk>
Cc: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>,
        Matan Ziv-Av <matan@svgalib.org>, mythos <papadako@csd.uoc.gr>,
        linux-kernel@vger.kernel.org
Subject: Re: Can't compile 2.4.3 with agcc 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 24 Apr 2001 13:37:49 +0100
Message-ID: <19649.988115869@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


rmk@arm.linux.org.uk said:
>  grep '__BUG__' System.map | cut -d\  -f3

Nice try, but nothing prevents even a correct compiler from including it in 
System.map even though it wouldn't have been called.


--
dwmw2


