Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965049AbVIADOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbVIADOo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 23:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbVIADOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 23:14:44 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:40361 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S965049AbVIADOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 23:14:43 -0400
Subject: Re: [PATCH 2.6] I2C: Drop I2C_DEVNAME and i2c_clientname
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Greg KH <greg@kroah.com>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com
In-Reply-To: <20050831205604.GJ19361@kroah.com>
References: <20050815195704.7b61206e.khali@linux-fr.org>
	 <1124741348.4516.51.camel@localhost>
	 <20050825001958.63b2525c.khali@linux-fr.org>
	 <1125360762.6186.29.camel@localhost>
	 <20050830232008.3420f0f1.khali@linux-fr.org>
	 <1125502498.9401.99.camel@localhost>  <20050831205604.GJ19361@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 01 Sep 2005 00:14:27 -0300
Message-Id: <1125544467.16937.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3-7mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qua, 2005-08-31 às 13:56 -0700, Greg KH escreveu:
> On Wed, Aug 31, 2005 at 12:34:58PM -0300, Mauro Carvalho Chehab wrote:
> > Em Ter, 2005-08-30 ?s 23:20 +0200, Jean Delvare escreveu:
> > > Hi Mauro,
> > > 
> > > > (...) it would be nice not to have a different I2C
> > > > API for every single 2.6 version :-) It would be nice to change I2C
> > > > API once and keep it stable for a while.
> > 
> > > The Linux 2.6 development model is designed around a relatively fast
> > > move from -mm to Linus' tree, which implies incremental changes all the
> > > time. I'm only doing that.
> > 	It is ok to change code, but, IMHO, API should be more stable.
> 
> I take it you have not read Documentation/stable_api_nonsense.txt yet?
	No I din't :-)
> If not, please do, it shows that what you are asking for will not
> happen.
	I was not asking for a 'stable' one.. but a less variant... anyway, I
can survive with this policy ;-)
> 
> good luck,
> 
> greg k-h
> 
Cheers, 
Mauro.

