Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbVLDNxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbVLDNxx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 08:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbVLDNxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 08:53:52 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:22182 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932219AbVLDNxw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 08:53:52 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Date: Sun, 4 Dec 2005 15:53:34 +0200
User-Agent: KMail/1.8.2
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
References: <20051203135608.GJ31395@stusta.de> <20051203152339.GK31395@stusta.de> <1133624383.22170.23.camel@laptopd505.fenrus.org>
In-Reply-To: <1133624383.22170.23.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512041553.34195.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 December 2005 17:39, Arjan van de Ven wrote:
> > IOW, we should e.g. ensure that today's udev will still work flawlessly 
> > with kernel 2.6.30 (sic)?
> 
> I'd say yes. It doesn't need to support all new functionality, but at
> least what it does today it should be able to do then. If that really
> isn't possible maybe udev should be part of the kernel build and per
> kernel version.

I agree with this idea.
--
vda
