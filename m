Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbUB1NPo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 08:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbUB1NPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 08:15:43 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:29190 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261842AbUB1NPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 08:15:42 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>, linux-kernel@vger.kernel.org
Subject: Re: Where does this load come from?
Date: Sat, 28 Feb 2004 15:04:41 +0200
User-Agent: KMail/1.5.4
References: <1077971267.10257.24.camel@paragon.slim>
In-Reply-To: <1077971267.10257.24.camel@paragon.slim>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402281504.41993.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 February 2004 14:27, Jurgen Kramer wrote:
> Hi,
>
> I am seeing some strange load figures on my P4 Celeron based system
> which I cannot explain. There always seem to be some load while there
> are no real apps running. Stopping all daemons doesn't seem to effect
> things at all.
>
> Output from top with 2.6.4-rc1:
>
>  13:16:38  up 38 min,  1 user,  load average: 1.67, 1.74, 1.57
> 62 processes: 59 sleeping, 3 running, 0 zombie, 0 stopped
> CPU states:  47.5% user  52.4% system   0.0% nice   0.0% iowait   0.0%
> idle
> Mem:   515552k av,   93544k used,  422008k free,       0k shrd,   10980k
> buff
>         49632k active,              29284k inactive
> Swap:  265064k av,       0k used,  265064k free                   59836k
> cached

Post unabridged 'top b n 1' please.
Top version?
--
vda

