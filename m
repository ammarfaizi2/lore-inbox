Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273900AbRI0VEj>; Thu, 27 Sep 2001 17:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273902AbRI0VE3>; Thu, 27 Sep 2001 17:04:29 -0400
Received: from jason.blazeconnect.net ([208.255.12.2]:9859 "HELO
	localhost.blazeconnect.net") by vger.kernel.org with SMTP
	id <S273900AbRI0VEW>; Thu, 27 Sep 2001 17:04:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jason Straight <jason@blazeconnect.net>
To: Morten Stenseth <nfp3033@privat.cybercity.no>
Subject: Re: regarding 2.4.10 power managment lockup
Date: Thu, 27 Sep 2001 17:04:16 -0400
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <1001467024.3307.4.camel@cartman>
In-Reply-To: <1001467024.3307.4.camel@cartman>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010927210416.49C837CA@localhost.blazeconnect.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This did the trick - 2.4.10 running like a charm now.
Thanks.

On Tuesday 25 September 2001 21:17, you wrote:
> Had the same problem as you , but tried to
> remove "APIC and IO-APIC support on uniprocessors" and
> now everything seems to work. :-)
>
> Morten

-- 
------------------------------------------
Jeet Kune Do does not beat around the bush. It does not take winding detours. 
It follows a straight line to the objective. Simplicity is the shortest 
distance between two points.
Bruce Lee - Tao of Jeet Kune Do
------------------------------------------

Jason Straight -- President
BlazeConnect -- Cheboygan Michigan
Phone: 231-597-0376 -- Fax: 231-597-0393
