Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262532AbTCRQHM>; Tue, 18 Mar 2003 11:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262539AbTCRQHL>; Tue, 18 Mar 2003 11:07:11 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:22284 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S262532AbTCRQGF>; Tue, 18 Mar 2003 11:06:05 -0500
Message-Id: <200303181616.h2IGGZUc020594@pincoya.inf.utfsm.cl>
To: jlnance@unity.ncsu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: modutils for 2.5 
In-reply-to: Your message of "Mon, 17 Mar 2003 14:37:11 EST."
             <20030317193711.GA28719@ncsu.edu> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Tue, 18 Mar 2003 12:16:35 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jlnance@unity.ncsu.edu said:
> On Mon, Mar 17, 2003 at 11:01:36AM -0800, Bob Miller wrote:
> > Yes there is.  Look in:
> > 
> > 	ftp.kernel.org://pub/linux/kernel/people/rusty/modules
> 
> Any idea if installing this break a redhat-8 kernel upgrade? 

Sure breaks the initrd. You ned to futz around and install the old
insmod.static into the initrd.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
