Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265019AbSLHAwe>; Sat, 7 Dec 2002 19:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbSLHAwe>; Sat, 7 Dec 2002 19:52:34 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:45237 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265019AbSLHAwd>; Sat, 7 Dec 2002 19:52:33 -0500
Subject: Re: Dazed and Confused
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg Boyce <gboyce@rakis.net>
In-Reply-To: <m3znripvs6.fsf@defiant.pm.waw.pl>
References: <Pine.LNX.4.42.0212061202230.7770-100000@egg> 
	<m3znripvs6.fsf@defiant.pm.waw.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Dec 2002 01:36:03 +0000
Message-Id: <1039311363.27925.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-06 at 23:33, Krzysztof Halasa wrote:
> CPU caches do ECC as well, and possibly can generate NMI requests. However,
> they use static RAM (as opposed to dynamic) and bit errors should not
> happen there.

CPU caches generate MCA/MCE on pentium pro and higher it appears rather
than NMI from the core logic

