Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWAaPfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWAaPfE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 10:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbWAaPfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 10:35:04 -0500
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:16320 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750956AbWAaPfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 10:35:01 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Beber <beber.lkml@gmail.com>
Subject: Re: 2.6.15-ck3
Date: Wed, 1 Feb 2006 02:34:54 +1100
User-Agent: KMail/1.9
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
References: <200601312319.20403.kernel@kolivas.org> <4615f4910601310732u79bd1427o9e34ced7baf860c8@mail.gmail.com>
In-Reply-To: <4615f4910601310732u79bd1427o9e34ced7baf860c8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602010234.54317.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 February 2006 02:32, Beber wrote:
> Hi,
>
> A chance to have linux-ck under git ?

No, sorry. A series of patches that remain a series of patches from one 
version to the next is much easier and simpler for me to maintain as a quilt 
series (http://savannah.nongnu.org/projects/quilt). The closest I come to 
automation is support for 'ketchup'.

Cheers,
Con
