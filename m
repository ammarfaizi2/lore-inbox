Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWDGFxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWDGFxO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 01:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWDGFxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 01:53:14 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:52673 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932284AbWDGFxN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 01:53:13 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: gene.heskett@verizononline.net
Subject: Re: [RFC: 2.6 patch] the overdue removal of RAW1394_REQ_ISO_{LISTEN,SEND}
Date: Fri, 7 Apr 2006 08:52:36 +0300
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20060406224706.GD7118@stusta.de> <200604062035.23880.gene.heskett@verizon.net>
In-Reply-To: <200604062035.23880.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604070852.36924.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 April 2006 03:35, Gene Heskett wrote:
> >This patch contains the overdue removal of the RAW1394_REQ_ISO_SEND
> > and RAW1394_REQ_ISO_LISTEN request types plus all support code for
> > them.
> >
> >Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> NAK if my vote is worth $.02.  ieee1394 has been broken since 
> 2.6.13-rc1, and apparently no one cares.  I have a firewire movie 
> camera I haven't been able to use since then.  A Sony DVR-TVR460.

You may help by narrowing it down to exact 2.6.x[-rcY] where it broke.
--
vda
