Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268868AbTCCXRG>; Mon, 3 Mar 2003 18:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268874AbTCCXRF>; Mon, 3 Mar 2003 18:17:05 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:22685
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268868AbTCCXQN>; Mon, 3 Mar 2003 18:16:13 -0500
Subject: Re: Errors in i810 DRM driver, 2.4.21-pre5-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Roskin <proski@gnu.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50.0303031730410.20127-100000@marabou.research.att.com>
References: <Pine.LNX.4.50.0303031730410.20127-100000@marabou.research.att.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046737847.7949.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 04 Mar 2003 00:30:48 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-03 at 23:00, Pavel Roskin wrote:
> Hello!
> 
> When I boot 2.4.21-pre5-ac1 on a system with an i810 card and i810 DRM
> supported in the kernel, following lines are printed continuously to the
> kernel log:

The DRM in -ac is for XFree86 4.2.99/4.3. It ought to be working in 4.2 as 
well but apparently not. 

