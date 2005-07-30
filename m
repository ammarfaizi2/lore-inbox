Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263088AbVG3Rza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbVG3Rza (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 13:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbVG3Rza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 13:55:30 -0400
Received: from 69.36.162.216.west-datacenter.net ([69.36.162.216]:32400 "EHLO
	schau.com") by vger.kernel.org with ESMTP id S263088AbVG3Ryx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 13:54:53 -0400
Message-ID: <42EBBF17.5010503@schau.com>
Date: Sat, 30 Jul 2005 19:55:35 +0200
From: Brian Schau <brian@schau.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.13-rc4] Bug in the wireless code?
References: <42EB94BC.3030604@schau.com> <200507301802.49019.vda@ilport.com.ua>
In-Reply-To: <200507301802.49019.vda@ilport.com.ua>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis/All,


I see the error in 2.6.12 as well (I just tried it).   My setup ...

Zyxel ZyAir B-100 pcmcia wireless card.
D-Link AccessPoint.


/brian


Denis Vlasenko wrote:
> On Saturday 30 July 2005 17:54, Brian Schau wrote:
> 
>>Hello,
>>
>>I am sorry to annoy you all.  I have problem in getting the
>>wireless orinoco driver to work in 2.6.13-rc4.   It works
>>like a charm in 2.6.11.
>>Doing a diff between the files for orinoco shows a lot of
>>differences.
>>
>>I'll gladly assist in any way I can.
> 
> 
> Does it work in 2.6.12? 2.6.13-rc1? rc2? rc3?
> 
> (Please do not reply just to me, but to lkml)
> --
> vda
> 
> 
