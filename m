Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135622AbRDXNoW>; Tue, 24 Apr 2001 09:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135616AbRDXNm3>; Tue, 24 Apr 2001 09:42:29 -0400
Received: from t2.redhat.com ([199.183.24.243]:4084 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S135615AbRDXNmV>; Tue, 24 Apr 2001 09:42:21 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200104241328.f3ODSFrn011684@pincoya.inf.utfsm.cl> 
In-Reply-To: <200104241328.f3ODSFrn011684@pincoya.inf.utfsm.cl> 
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Russell King <rmk@arm.linux.org.uk>, mythos <papadako@csd.uoc.gr>,
        linux-kernel@vger.kernel.org
Subject: Re: Can't compile 2.4.3 with agcc 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 24 Apr 2001 14:30:09 +0100
Message-ID: <26559.988119009@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


vonbrand@inf.utfsm.cl said:
>  These "broken and cryptic" checks have been done several times now.
> You could certainly add a note to this effect to the documentation on
> building the kernel.

> Building a known broken kernel just for the sake of "better error
> reporting" is dead wrong, IMO.

The fact that the error is reported in a cryptic fashion is a minor issue. 
The important point is that the check itself is broken and not guaranteed 
to work even with good compilers. 

--
dwmw2


