Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318244AbSGQIyE>; Wed, 17 Jul 2002 04:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318246AbSGQIyD>; Wed, 17 Jul 2002 04:54:03 -0400
Received: from ns.suse.de ([213.95.15.193]:57355 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318244AbSGQIyB>;
	Wed, 17 Jul 2002 04:54:01 -0400
Date: Wed, 17 Jul 2002 10:56:50 +0200
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Schaper <schaper@inet.net.nz>, linux-kernel@vger.kernel.org
Subject: Re: A kernel bug of sorts...
Message-ID: <20020717105650.I2994@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	John Schaper <schaper@inet.net.nz>, linux-kernel@vger.kernel.org
References: <000501c22d48$e6940230$0200a8c0@john> <1026896093.2119.124.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1026896093.2119.124.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 09:54:53AM +0100, Alan Cox wrote:
 > On Wed, 2002-07-17 at 05:17, John Schaper wrote:
 > > Just a quick note... it appears that "i2c-old.h" has been omitted from the
 > > 2.5.25 kernel source (tar.bz2).
 > 
 > This is intentional to encourage people to finish porting to the newer
 > i2c code

Frank Davis and others have done some conversions in my tree.  Either
no-one has tried these, or they're perfect.  I'll push them to Linus
as soon as I get back from Germany and resync with current.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
