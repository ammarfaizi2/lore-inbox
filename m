Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130872AbRBNUl0>; Wed, 14 Feb 2001 15:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130848AbRBNUlQ>; Wed, 14 Feb 2001 15:41:16 -0500
Received: from innerfire.net ([208.181.73.33]:60177 "HELO innerfire.net")
	by vger.kernel.org with SMTP id <S130836AbRBNUlG>;
	Wed, 14 Feb 2001 15:41:06 -0500
Date: Wed, 14 Feb 2001 12:43:19 -0800 (PST)
From: Gerhard Mack <gmack@innerfire.net>
To: Jeremy Jackson <jeremy.jackson@sympatico.ca>
cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: Is this the ultimate stack-smash fix?
In-Reply-To: <3A8ADA30.2936D3B1@sympatico.ca>
Message-ID: <Pine.LNX.4.10.10102141242190.4677-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there any documentation of the kernel's 'capabilities' functions?  It
> would be exceedingly cool if services (named, nfs, etc)
> could be updated to use this;  I think crackers would loose some motivation
> if instead of "hey I can totally rule this box!"
> they have to settle for "hey I can make the ident service report user 'CrAp'
> for every port!".

Named and proftpd are already updated to use this.. check the source
for the best documentation ...

	Gerhard




--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

