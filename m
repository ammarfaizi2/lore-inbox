Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262299AbVFIGij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbVFIGij (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 02:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbVFIGii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 02:38:38 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:53906 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262299AbVFIGhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 02:37:41 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: ipw2100: firmware problem
Date: Thu, 9 Jun 2005 09:37:25 +0300
User-Agent: KMail/1.5.4
Cc: abonilla@linuxwireless.org, pavel@ucw.cz, jgarzik@pobox.com,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       ipw2100-admin@linux.intel.com
References: <200506090909.55889.vda@ilport.com.ua> <200506090925.07495.vda@ilport.com.ua> <20050608.232818.31644993.davem@davemloft.net>
In-Reply-To: <20050608.232818.31644993.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506090937.25634.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 June 2005 09:28, David S. Miller wrote:
> From: Denis Vlasenko <vda@ilport.com.ua>
> Date: Thu, 9 Jun 2005 09:25:07 +0300
> 
> > You need to up interface? And surely you need ip addr? That's a knob also! :)
> 
> There's this thing called DHCP which takes care of this for me.
> With IPV6, even less configuration can be necessary.

But DHCP does not start by itself, and it shuldn't.
You start dhcp client. That is a "minimal config" in this case.

Anyway, I think I start trolling... I should stop now.
--
vda

