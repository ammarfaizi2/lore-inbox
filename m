Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132949AbRDEQDv>; Thu, 5 Apr 2001 12:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132948AbRDEQDc>; Thu, 5 Apr 2001 12:03:32 -0400
Received: from t2.redhat.com ([199.183.24.243]:17915 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S132947AbRDEQD1>; Thu, 5 Apr 2001 12:03:27 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <911e4990c632.90c632911e49@student.uva.nl> 
In-Reply-To: <911e4990c632.90c632911e49@student.uva.nl> 
To: rudmer.vandijk@student.uva.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: cannot compile kernel 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Date: Thu, 05 Apr 2001 17:02:44 +0100
Message-ID: <18969.986486564@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rudmer.vanDijk@student.uva.nl said:
> compiler (gcc --version): pgcc-2.95.2 

> I hope i have included enough information for you and that you will be
>  able to solve my problem. 

grep --context pgcc Documentation/Changes

See also http://www.tux.org/lkml/#s8-9, #s8-5 and indeed most of the rest
of §8.

--
dwmw2


