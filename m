Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262913AbSLQB2o>; Mon, 16 Dec 2002 20:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263279AbSLQB2n>; Mon, 16 Dec 2002 20:28:43 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:46816
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262913AbSLQB2n>; Mon, 16 Dec 2002 20:28:43 -0500
Subject: Re: Linux 2.2.24-rc1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Pawel Kot <pkot@linuxnews.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021217010612.GA32560@suse.de>
References: <Pine.LNX.4.33.0212170113350.14563-100000@urtica.linuxnews.pl>
	<1040088833.13837.115.camel@irongate.swansea.linux.org.uk> 
	<20021217010612.GA32560@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Dec 2002 02:16:22 +0000
Message-Id: <1040091382.13786.121.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-17 at 01:06, Dave Jones wrote:

>  > If we get a vendor string, we should use it - thats all
> 
> This patch also makes us unconditionally skip the mcheck_init
> if we have a vendor string. That doesn't seem right.

True.. ok its more complicated to fix 8(

