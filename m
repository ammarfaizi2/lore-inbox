Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291245AbSBRSzY>; Mon, 18 Feb 2002 13:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291198AbSBRSy3>; Mon, 18 Feb 2002 13:54:29 -0500
Received: from dsl-65-185-109-125.telocity.com ([65.185.109.125]:26500 "EHLO
	ohdarn.net") by vger.kernel.org with ESMTP id <S285273AbSBRSsW>;
	Mon, 18 Feb 2002 13:48:22 -0500
Subject: Re: Kernel 2.4.18-pre9-mjc2 breaks some netfilter modules
From: Michael Cohen <me@ohdarn.net>
To: linux-kernel@vger.kernel.org
Cc: kilobug@freesurf.fr
In-Reply-To: <3C6F946F.6030207@freesurf.fr>
In-Reply-To: <3C6F946F.6030207@freesurf.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 18 Feb 2002 13:48:21 -0500
Message-Id: <1014058101.32538.2.camel@ohdarn.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-02-17 at 06:30, Kilobug wrote:
> Hello,
> 	I've upgraded from 2.4.18-pre3-mjc3 to 2.4.18-pre9-mjc2 and the following 
> netfilter modules are now broken:
> 
I've noticed this, and already have a fix slated for 2.4.18-rc1-mjc1. 
Thanks for reporting it though. Every little bit helps.

------
Michael Cohen
OhDarn.net


