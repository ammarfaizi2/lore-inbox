Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318107AbSHIBGY>; Thu, 8 Aug 2002 21:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318109AbSHIBGY>; Thu, 8 Aug 2002 21:06:24 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:48117 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318107AbSHIBGX>; Thu, 8 Aug 2002 21:06:23 -0400
Subject: Re: [2.6] The List, pass #2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Guillaume Boissiere <boissiere@adiglobal.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D3761A9.23960.8EB1A2@localhost>
References: <3D3761A9.23960.8EB1A2@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 09 Aug 2002 03:30:11 +0100
Message-Id: <1028860211.28883.136.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-19 at 05:47, Guillaume Boissiere wrote:

Missed this originally

>   o Improved i2o (Intelligent Input/Ouput) layer

Improved I2O will make 2.6. The code in 2.5 is way behind 2.4 and
basically doesn't work. It also needs no core changes affecting anything
outside of I2O so its a driver item not a core feature by Oct 31

>   o Serial ATA support      

This should be in 2.4 soon. It will be essential by the time 2.6 is out.
I don't know what Martin's plans are for it, but again its pure driver
code so not a core issue

