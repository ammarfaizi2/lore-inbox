Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266998AbTCEXey>; Wed, 5 Mar 2003 18:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267008AbTCEXey>; Wed, 5 Mar 2003 18:34:54 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:59556
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266998AbTCEXew>; Wed, 5 Mar 2003 18:34:52 -0500
Subject: Re: kernel crash?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jianwen <jw.pi@servgate.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <022801c2e353$e4fd9550$0400130a@jianwen>
References: <022801c2e353$e4fd9550$0400130a@jianwen>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046911820.15950.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 06 Mar 2003 00:50:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-05 at 20:14, Jianwen wrote:
> Hi, there
> 
> I currently installed Redhat7.3 (kernel 2.4.18-3) and Squid-2.5-STABLE1
> running

Hard to tell from a first glance. Current errata kernel (newer than -3) would 
be good. The trace itself alas doesnt answer a lot. If you suspect it may be
RAM and can take the box out of service leave memtest86 running on it for a 
few hours and see what it turns up.

Its one of those apps I'd recommend running on any new production hardware for
a couple of passes before putting it into service

