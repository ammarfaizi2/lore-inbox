Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266027AbUFDUxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266027AbUFDUxi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 16:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266017AbUFDUvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 16:51:37 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:24070 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266011AbUFDUv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 16:51:28 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.7-rc2-bk4: empty-named directory in /sys
Date: Fri, 4 Jun 2004 23:50:53 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200406042253.23428.vda@port.imtp.ilyichevsk.odessa.ua> <20040604202653.GA13311@kroah.com>
In-Reply-To: <20040604202653.GA13311@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406042350.53428.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 June 2004 23:26, Greg KH wrote:
> Hm, is the hostap code in the main kernel tree now?  That's the only
> thing odd that I see from your messages.  Does this happen with
> 2.6.7-rc2 with no extra patches?

Hopefully it will be there soon ;)

AFAIK hostap do not use sysfs in any form.

I'll test it anyway.
--
vda

