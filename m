Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273246AbRIWDVj>; Sat, 22 Sep 2001 23:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273240AbRIWDV2>; Sat, 22 Sep 2001 23:21:28 -0400
Received: from mclean.mail.mindspring.net ([207.69.200.57]:9481 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273242AbRIWDVW>; Sat, 22 Sep 2001 23:21:22 -0400
Subject: Re: [PATCH] Preemption Latency Measurement Tool
From: Robert Love <rml@tech9.net>
To: george anzinger <george@mvista.com>
Cc: Andre Pang <ozone@algorithm.com.au>, linux-kernel@vger.kernel.org,
        safemode@speakeasy.net, Dieter.Nuetzel@hamburg.de, iafilius@xs4all.nl,
        ilsensine@inwind.it
In-Reply-To: <3BAD5493.EC4F845A@mvista.com>
In-Reply-To: <1000939458.3853.17.camel@phantasy>
	<1001131036.557760.4340.nullmailer@bozar.algorithm.com.au>
	<1001139027.1245.28.camel@phantasy>
	<1001143341.117502.5311.nullmailer@bozar.algorithm.com.au> 
	<3BAD5493.EC4F845A@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.21.20.26 (Preview Release)
Date: 22 Sep 2001 23:21:46 -0400
Message-Id: <1001215315.1390.1.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-09-22 at 23:18, george anzinger wrote:
> The one thing the latancytimes patch doesn't monitor is interrupt off
> time.  Maybe it should...

Yes, it should.  And it could... I will add this.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

