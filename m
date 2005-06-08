Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVFHNPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVFHNPL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 09:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVFHNPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 09:15:10 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:52118 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261180AbVFHNPF (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 09:15:05 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: pomac@vapor.com
Subject: Re: RFC: i386: kill !4KSTACKS
Date: Wed, 8 Jun 2005 16:14:46 +0300
User-Agent: KMail/1.5.4
Cc: Linux-kernel@vger.kernel.org
References: <1118234117.15194.23.camel@localhost>
In-Reply-To: <1118234117.15194.23.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506081614.46341.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 June 2005 15:35, Ian Kumlien wrote:
> > Number of folks using ndiswrapper for acx100/acx111
> > while acx team needs help on native driver debugging
> > worries me.
> 
> two things:
> 	1, Broadcom chipsets lack any kind of driver.
> 	2, acx100/111 claim that the firm ware is 'easy to find this is a ...
> lie... F.ex. d-links drivers come with the drivers embedded in some
> file, i was unable to extract it for my neighbur and ended up using
> ndiswrapper. There was no choise.
> 
> Thus your statement is premature.

acx driver would not improve if few people will use it.

Caring for ndiswrapper needs helps closed source binary drivers,
thus harms open source driver development.

Re firmware files: I've collected many at
http://195.66.192.167/linux/acx100/acx1xx.htm
--
vda

