Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264963AbTAACBv>; Tue, 31 Dec 2002 21:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264969AbTAACBv>; Tue, 31 Dec 2002 21:01:51 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:17162 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S264963AbTAACBu>; Tue, 31 Dec 2002 21:01:50 -0500
Message-Id: <200301010210.h012ABG4014534@pincoya.inf.utfsm.cl>
To: Joshua Stewart <joshua.stewart@comcast.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Production vs development version numbers 
In-Reply-To: Message from Joshua Stewart <joshua.stewart@comcast.net> 
   of "Tue, 31 Dec 2002 20:58:29 CDT." <1041386309.16613.5.camel@localhost.localdomain> 
Date: Tue, 31 Dec 2002 23:10:11 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Stewart <joshua.stewart@comcast.net>  said:

[...]

> If an even version is "stable", what types of differences are there
> between different patch levels of an even version, for example 2.4.x and
> 2.4.y.  Are these bug fixes, performance boosters, or functionality
> additions?

Usually; but not always. Sometimes support for new hardware is added, and
there have been cases on larger scale changes.

> Also, when fixes are made to a stable version kernel, such as those
> added to 2.4.19 to give us 2.4.20, do those fixes get incorporated into
> the current development version as well?

The two veersions usually diverge rather fast. Changes in the development
version are sometimes backported to the stable version(s), sometimes fixes
form the stable series find their way into the development series.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
