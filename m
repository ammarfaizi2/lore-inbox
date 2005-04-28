Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbVD1Pxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbVD1Pxz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 11:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVD1Pxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 11:53:55 -0400
Received: from baloney.puettmann.net ([194.97.54.34]:62387 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S261948AbVD1Pxx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 11:53:53 -0400
Date: Thu, 28 Apr 2005 17:53:13 +0200
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.7 kernel panic on boot on AMD64
Message-ID: <20050428155312.GC18972@puettmann.net>
References: <20050427140342.GG10685@puettmann.net> <20050427152704.632a9317.rddunlap@osdl.org> <20050428090539.GA18972@puettmann.net> <20050428084313.1e69f59d.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20050428084313.1e69f59d.rddunlap@osdl.org>
User-Agent: Mutt/1.5.9i
From: Ruben Puettmann <ruben@puettmann.net>
X-Scanner: exiscan *1DRBKD-0006Na-00*hsFB0asWsE.* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 08:43:13AM -0700, Randy.Dunlap wrote:
 
> Hm, no "console=tty...." at all.  That didn't help (me) much.
> 
> Does this happen consistently?

Yes ist does. With the DL385 with newest Bios and with a bunch ob Tyan
Opteron Boards. 
 
> What does "gcc --version" say?
> 

root@pergolesi:~# gcc --version
gcc (GCC) 3.3.5 (Debian 1:3.3.5-12)


Its pergolesi.debian.org one of the Debian Development Server.

                Ruben

-- 
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net
