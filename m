Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289766AbSAWKQx>; Wed, 23 Jan 2002 05:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289762AbSAWKQo>; Wed, 23 Jan 2002 05:16:44 -0500
Received: from ns.ithnet.com ([217.64.64.10]:33547 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S289761AbSAWKQi>;
	Wed, 23 Jan 2002 05:16:38 -0500
Date: Wed, 23 Jan 2002 11:16:36 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Urban Widmark <urban@teststation.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: via-rhine timeouts
Message-Id: <20020123111636.79ae93cd.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.33.0201231015300.6354-100000@cola.teststation.com>
In-Reply-To: <20020123010248.GB835@bouncybouncy.net>
	<Pine.LNX.4.33.0201231015300.6354-100000@cola.teststation.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002 10:44:17 +0100 (CET)
Urban Widmark <urban@teststation.com> wrote:

> On Tue, 22 Jan 2002, Justin A wrote:
> 
> > It only does that after resetting the card over and over again, perhaps
> > it tries to reset it again before its ready?
> 
> Andrew Morton sent me some stuff on this. It seems via changed the
> meaning of some register bits, but the driver doesn't understand that. So
> it reads certain status events all wrong and does the wrong thing.
> 
> I'll have a look and see if I can do something over the weekend.

Would be very nice to have some fix. These cards are in widespread use...

Regards,
Stephan

