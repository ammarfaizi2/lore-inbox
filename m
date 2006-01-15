Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751920AbWAOMwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbWAOMwX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 07:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751921AbWAOMwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 07:52:23 -0500
Received: from web53315.mail.yahoo.com ([206.190.49.105]:20058 "HELO
	web53315.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751920AbWAOMwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 07:52:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=nykENBeCvH/VyGci/lWu3Khz1+NgPpdnHDAYAV9xy+BhRhxZ5pPchKbScDjYP8DOdbCS4dCVyUFmhCm9TEsdRGqFegMi49D18yxlzNwD4RV18i5g4hv//509v2jO2wNE/rmqSiE0iuMX/ONhUMblwc7rs4WH6s4dOPSm5LjRtuI=  ;
Message-ID: <20060115125219.16012.qmail@web53315.mail.yahoo.com>
Date: Sun, 15 Jan 2006 04:52:19 -0800 (PST)
From: hugo vanwoerkom <hugovanwoerkom@yahoo.com>
Subject: Re: [ck] 2.6.15-ck2
To: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: ck list <ck@vds.kolivas.org>
In-Reply-To: <200601152106.22498.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Con Kolivas <kernel@kolivas.org> wrote:

<snip>

> 
> *NOTE*
> If you're looking for the 1GB lowmem option it has
> been replaced and you 
> should choose the following in menuconfig for the
> same effect:
> ( ) 3G/1G user/kernel split
> (X) 3G/1G user/kernel split (for full 1G low memory)
> ( ) 2G/2G user/kernel split
> ( ) 1G/3G user/kernel split

<snip>

When I have 1GB of memory, the option before was
clear.
What this now means, who knows... :-(
And there is no help for the options.

Hugo







__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
