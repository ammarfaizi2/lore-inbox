Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266613AbSKGWWo>; Thu, 7 Nov 2002 17:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266614AbSKGWWo>; Thu, 7 Nov 2002 17:22:44 -0500
Received: from fungus.teststation.com ([212.32.186.211]:15373 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S266613AbSKGWWo>; Thu, 7 Nov 2002 17:22:44 -0500
Date: Thu, 7 Nov 2002 23:28:33 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.enlightnet.local
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: !(smbfs && O_LARGEFILE)
In-Reply-To: <200211071750.34680.roy@karlsbakk.net>
Message-ID: <Pine.LNX.4.44.0211072325490.9298-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2002, Roy Sigurd Karlsbakk wrote:

> hi all
> 
> When will smbfs support O_LARGEFILE?
> I mean - smbfs tells me this, mounted from a win2k server

It's in 2.5. You just need to tell smbmount about it, see:

http://www.hojdpunkten.ac.se/054/samba/index.html

/Urban

