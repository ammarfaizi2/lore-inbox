Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267392AbTBFVSI>; Thu, 6 Feb 2003 16:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267410AbTBFVSI>; Thu, 6 Feb 2003 16:18:08 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:16801
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267392AbTBFVSH>; Thu, 6 Feb 2003 16:18:07 -0500
Subject: Re: NAT counting
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lamont Granquist <lamont@scriptkiddie.org>
Cc: Stephen Clark <sclark46@earthlink.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030206101319.P14724-100000@coredump.scriptkiddie.org>
References: <20030206101319.P14724-100000@coredump.scriptkiddie.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044570326.12098.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 06 Feb 2003 22:25:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-06 at 18:14, Lamont Granquist wrote:
> If anyone is working on fixing this, they'll also need to fix up TCP
> timestamps and maybe ISNs as well as IPids.

And encrypt all application level traffic very carefully, otherwise things
like web client headers, ftp context and the like will allow people to 
estimate some stuff.

