Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262712AbSLMMZ2>; Fri, 13 Dec 2002 07:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262500AbSLMMZ2>; Fri, 13 Dec 2002 07:25:28 -0500
Received: from mail.iwr.uni-heidelberg.de ([129.206.104.30]:28375 "EHLO
	mail.iwr.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S262486AbSLMMZ1>; Fri, 13 Dec 2002 07:25:27 -0500
Date: Fri, 13 Dec 2002 13:33:16 +0100 (CET)
From: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
To: Andrew McGregor <andrew@indranet.co.nz>
cc: "David S. Miller" <davem@redhat.com>, <dlstevens@us.ibm.com>,
       <matti.aarnio@zmailer.org>, <niv@us.ibm.com>,
       <alan@lxorguk.ukuu.org.uk>, <stefano.andreani.ap@h3g.it>,
       <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>
Subject: Re: R: Kernel bug handling TCP_RTO_MAX?
In-Reply-To: <19000000.1039780134@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0212131321400.11129-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Dec 2002, Andrew McGregor wrote:

> You're going to make lots of IETFer's really annoyed by suggesting that :-)

I hope not. That was the reason for allowing it to be tuned and for having 
a default value equal to the existing one.

> In a closed network, why not have SOCK_STREAM map to something faster than 
> TCP anyway?

Sure, just give me a protocol that:
- is reliable
- has low latency
- comes with the standard kernel
and I'll just use it. But you always get only 2 out ot 3...

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De

