Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbVFIG1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVFIG1q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 02:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbVFIG1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 02:27:46 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:3508 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262285AbVFIGZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 02:25:48 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: ipw2100: firmware problem
Date: Thu, 9 Jun 2005 09:25:07 +0300
User-Agent: KMail/1.5.4
Cc: abonilla@linuxwireless.org, pavel@ucw.cz, jgarzik@pobox.com,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       ipw2100-admin@linux.intel.com
References: <002901c56c3b$8216cdd0$600cc60a@amer.sykes.com> <200506090909.55889.vda@ilport.com.ua> <20050608.231657.59660080.davem@davemloft.net>
In-Reply-To: <20050608.231657.59660080.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506090925.07495.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 June 2005 09:16, David S. Miller wrote:
> From: Denis Vlasenko <vda@ilport.com.ua>
> Date: Thu, 9 Jun 2005 09:09:55 +0300
> 
> > On Wednesday 08 June 2005 18:05, Alejandro Bonilla wrote:
> > > Currently, when we install the driver, it associates to any open network on
> > > boot. This is good, cause we don't want to be typing the commands all the
> > > time just to associate. It works this way now and is pretty nice.
> > 
> > What is so nice about this? That Linux novice user with his new lappie
> > will join a neighbor's network every time he powers up the lappie,
> > even without knowing that?
> 
> I love this behavior, because it means that I don't have to do
> anything special to get my setup at home working.
> 
> Me caveman
> Me plug in wireless router
> Me watch pretty lights
> Me turn on computer
> Me up interface

You need to up interface? And surely you need ip addr? That's a knob also! :)

> Computer work
> Me no care other cavemen use wireless link
> 
> Configuration knobs are _madness_.  Things should work with minimal
> intervention and configuration.

Sure. I consider "iwconfig essid MyCave mode managed" a minimal intervention,
just like I consider "ip a a dev eth0 123.123.123.2/24 brd +; ip l set dev eth0 up"
a miniman interventian if I need IP configured.
--
vda

