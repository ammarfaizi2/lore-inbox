Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132471AbRDWWgM>; Mon, 23 Apr 2001 18:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132488AbRDWWgI>; Mon, 23 Apr 2001 18:36:08 -0400
Received: from t2.redhat.com ([199.183.24.243]:44281 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S132471AbRDWWfv>; Mon, 23 Apr 2001 18:35:51 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200104232225.f3NMPHrn001690@pincoya.inf.utfsm.cl> 
In-Reply-To: <200104232225.f3NMPHrn001690@pincoya.inf.utfsm.cl> 
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Russell King <rmk@arm.linux.org.uk>, mythos <papadako@csd.uoc.gr>,
        linux-kernel@vger.kernel.org
Subject: Re: Can't compile 2.4.3 with agcc 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 23 Apr 2001 23:35:38 +0100
Message-ID: <4624.988065338@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



vonbrand@inf.utfsm.cl said:
>  Your patch (tries to) transform a compile and link time check into a
> runtime check. Not nice.

It transforms a broken and cryptic compile-time check into a correct and
informative runtime check.

If you can provide a correct and informative compile-time check, that would 
be wonderful.

--
dwmw2


