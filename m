Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275716AbRI0AKr>; Wed, 26 Sep 2001 20:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275714AbRI0AKh>; Wed, 26 Sep 2001 20:10:37 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43022 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S275712AbRI0AKY>; Wed, 26 Sep 2001 20:10:24 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: newsgroup of all mailing lists ?
Date: 26 Sep 2001 17:10:37 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9otqpt$6q7$1@cesium.transmeta.com>
In-Reply-To: <B7D7DFB1.8013%little.jones.family@ntlworld.com> <20010927013522.I11046@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010927013522.I11046@mea-ext.zmailer.org>
By author:    Matti Aarnio <matti.aarnio@zmailer.org>
In newsgroup: linux.dev.kernel
> 
>   It is not trivial.
> 
>   We ( postmaster@vger.kernel.org ) don't recommend making bidirectional
>   gateways -- one mistake there, and the system causes duplication of
>   messages at the list it is linked with.   When we detect that mistake,
>   the usual court-martial is swift, and feed from VGER to the GW is
>   removed instantly.
> 
>   I think these loop problems were one of the reasons why one of us
>   (DaveM) strongly opposes list<->news gateways.  I am somewhat less
>   in opposition, and my thinking is that the only way we can have
>   reliable (hah!) list<->news gw is by running it centralized at VGER.
>   Modern VGER has muscle for it, but don't expect it to happen any
>   time soon.
> 

I actually had such a centralized gateway ran at one time.  It's still
running locally at Transmeta.

The only sane way to do this is in a centralized fashion, distributed
outbound via the standard news mechanisms.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
