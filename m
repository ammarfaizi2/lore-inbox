Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbWABUFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWABUFe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 15:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWABUFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 15:05:34 -0500
Received: from khc.piap.pl ([195.187.100.11]:19460 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751004AbWABUFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 15:05:33 -0500
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Adrian Bunk <bunk@stusta.de>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
References: <20051229224839.GA12247@elte.hu>
	<1135897092.2935.81.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de>
	<20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de>
	<20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de>
	<20060102103721.GA8701@elte.hu>
	<1136198902.2936.20.camel@laptopd505.fenrus.org>
	<20060102134345.GD17398@stusta.de> <20060102140511.GA2968@elte.hu>
	<m3ek3qcvwt.fsf@defiant.localdomain>
	<1136227893.2936.51.camel@laptopd505.fenrus.org>
	<m34q4mpfz9.fsf@defiant.localdomain>
	<1136231656.2936.57.camel@laptopd505.fenrus.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 02 Jan 2006 21:05:31 +0100
In-Reply-To: <1136231656.2936.57.camel@laptopd505.fenrus.org> (Arjan van de Ven's message of "Mon, 02 Jan 2006 20:54:16 +0100")
Message-ID: <m3sls6o0ok.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

> it's by far not only gains. And maintenance costs too.

Anyway, distinctive "inlines" could help here, right?
-- 
Krzysztof Halasa
