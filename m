Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293471AbSCASMy>; Fri, 1 Mar 2002 13:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293469AbSCASMe>; Fri, 1 Mar 2002 13:12:34 -0500
Received: from ns.suse.de ([213.95.15.193]:52238 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S293467AbSCASMY>;
	Fri, 1 Mar 2002 13:12:24 -0500
To: Kain <kain@kain.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS: Multipath routing 2.4.17
In-Reply-To: <20020301173414.GA30037@kain.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 01 Mar 2002 19:12:12 +0100
In-Reply-To: Kain's message of "1 Mar 2002 18:39:02 +0100"
Message-ID: <p731yf4kvib.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kain <kain@kain.org> writes:

> I am running a mailserver on linux 2.4.17 with equal-cost multi-path
> routing to 2 local routers, and I am able to OOPS the machine under
> moderate load with the multipath route installed. Attached is a decoded
> OOPS log as well as my .config.
> 
> These are my log messages immediately before the OOPS:
> 
> impossible 888
> divide error: 0000

They should be after, not before the oops. 

What compiler are you using? 

-Andi
