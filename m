Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317812AbSFMTzF>; Thu, 13 Jun 2002 15:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317814AbSFMTzE>; Thu, 13 Jun 2002 15:55:04 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:28430 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S317812AbSFMTzD>; Thu, 13 Jun 2002 15:55:03 -0400
Message-Id: <200206131953.g5DJrnHK014229@pincoya.inf.utfsm.cl>
To: Lincoln Dale <ltd@cisco.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: per-socket statistics on received/dropped packets 
In-Reply-To: Message from Lincoln Dale <ltd@cisco.com> 
   of "Thu, 13 Jun 2002 12:52:05 +1000." <5.1.0.14.2.20020613124142.03292410@mira-sjcm-3.cisco.com> 
Date: Thu, 13 Jun 2002 15:53:49 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lincoln Dale <ltd@cisco.com> said:

[...]

> but seeing as a HTTP cache is in essence glueing two TCP connections 
> togethers, whats to say that the client wouldn't have had the TCP 
> retransmissions in the first place?  all i'm talking about is ensuring that 
> application "accounting" information is accurate.

Strange charging model, if you ask me. If "somebody" hogs the connection,
causing my data streams to need retransmissions, I get charged. If I happen
to surf to <http://www.some.exciting.site.org> as the first customer today,
I get charged, everybody else gets it for free off the cache.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
