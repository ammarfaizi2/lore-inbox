Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313508AbSD3NYG>; Tue, 30 Apr 2002 09:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313533AbSD3NYF>; Tue, 30 Apr 2002 09:24:05 -0400
Received: from ip68-1-63-129.pn.at.cox.net ([68.1.63.129]:1152 "EHLO
	dps2.dpscon.com") by vger.kernel.org with ESMTP id <S313508AbSD3NYF>;
	Tue, 30 Apr 2002 09:24:05 -0400
Date: Tue, 30 Apr 2002 08:24:26 -0500
Message-Id: <200204301324.g3UDOQW00938@dps2.dpscon.com>
From: "Billy O'Connor" <billy@dpscon.com>
To: indigoid@higherplane.net
CC: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
In-Reply-To: <20020430131523.GA22705@higherplane.net>
	(indigoid@higherplane.net)
Subject: Re: [prepatch] address_space-based writeback
Reply-to: billy@dpscon.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   On Tue, Apr 30, 2002 at 03:19:17PM -0200, Denis Vlasenko wrote:
   > Why do we have to stich to concept of inode *numbers*?
   > Because there are inode numbers in traditional Unix filesystems?

   like much of unix it's been there forever and has become such a natural
   concept in people's heads that to change it now seems unthinkable.

   much like the missing e in creat().

Wasn't that the one thing Ken Thompson said he would do differently
if he had it to do all over(unix)?
