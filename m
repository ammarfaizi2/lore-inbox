Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262202AbRFNMHp>; Thu, 14 Jun 2001 08:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262262AbRFNMHf>; Thu, 14 Jun 2001 08:07:35 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:57097 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S262202AbRFNMH2>; Thu, 14 Jun 2001 08:07:28 -0400
Message-Id: <200106141207.f5EC7CA4030080@pincoya.inf.utfsm.cl>
To: David Luyer <david_luyer@pacific.net.au>
cc: "Rainer Mager" <rmager@vgkk.com>, linux-kernel@vger.kernel.org
Subject: Re: Download process for a "split kernel" (was: obsolete code must die) 
In-Reply-To: Message from David Luyer <david_luyer@pacific.net.au> 
   of "Thu, 14 Jun 2001 12:00:23 +1000." <200106140200.f5E20NL3012987@typhaon.pacific.net.au> 
Date: Thu, 14 Jun 2001 08:07:11 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Luyer <david_luyer@pacific.net.au> said:

[...]

> This might actually make sense - a kernel composed of multiple versioned
> segments.  A tool which works out dependencies of the options being selected,
> downloads the required parts if the latest versions of those parts are not
> already downloaded, and then builds the kernel (or could even build during
> the download, as soon as the build dependencies for each block of the kernel
> are satisfied, if you want to be fancy...).

Please do look at the archives to find out just why this idea is floated
each 3 to 4 months and then shot down, and why.
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
