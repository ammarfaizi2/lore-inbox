Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262355AbRFFM17>; Wed, 6 Jun 2001 08:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262389AbRFFM1t>; Wed, 6 Jun 2001 08:27:49 -0400
Received: from innominate.intercity.it ([151.39.132.18]:35827 "HELO ashland")
	by vger.kernel.org with SMTP id <S262355AbRFFM1n>;
	Wed, 6 Jun 2001 08:27:43 -0400
To: linux-kernel@vger.kernel.org
Subject: temperature standard - global config option?
From: davidw@apache.org (David N. Welton)
Date: 06 Jun 2001 14:27:22 +0200
Message-ID: <87snhdvln9.fsf@apache.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ please CC replies to me ]

Perusing the kernel sources while investigating watchdog drivers, I
notice that in some places, Fahrenheit is used, and in some places,
Celsius.  It would seem logical to me to have a global config option,
so that you *know* that you talk devices either in F or C.

I searched the archives for discussions regarding this, but didn't
find anything, apologies if I missed something.

-- 
David N. Welton
Free Software: http://people.debian.org/~davidw/
   Apache Tcl: http://tcl.apache.org/
     Personal: http://www.efn.org/~davidw/
         Work: http://www.innominate.com/
