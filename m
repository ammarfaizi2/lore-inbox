Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262334AbVFIIgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbVFIIgK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 04:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVFIIgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 04:36:10 -0400
Received: from levante.wiggy.net ([195.85.225.139]:52949 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S262334AbVFIIgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 04:36:06 -0400
Date: Thu, 9 Jun 2005 10:36:00 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: "David S. Miller" <davem@davemloft.net>, abonilla@linuxwireless.org,
       pavel@ucw.cz, jgarzik@pobox.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, ipw2100-admin@linux.intel.com
Subject: Re: ipw2100: firmware problem
Message-ID: <20050609083600.GE1478@wiggy.net>
Mail-Followup-To: Denis Vlasenko <vda@ilport.com.ua>,
	"David S. Miller" <davem@davemloft.net>, abonilla@linuxwireless.org,
	pavel@ucw.cz, jgarzik@pobox.com, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org, ipw2100-admin@linux.intel.com
References: <200506090909.55889.vda@ilport.com.ua> <200506090925.07495.vda@ilport.com.ua> <20050608.232818.31644993.davem@davemloft.net> <200506090937.25634.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506090937.25634.vda@ilport.com.ua>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Denis Vlasenko wrote:
> But DHCP does not start by itself, and it shuldn't.

It does in most modern distros as far as I know. They use ifplugd or a
similar tool to monitor link status and configure the interface if a link is
detected.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
