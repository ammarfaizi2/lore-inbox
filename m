Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317521AbSHGNne>; Wed, 7 Aug 2002 09:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317402AbSHGNne>; Wed, 7 Aug 2002 09:43:34 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:7164 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S317390AbSHGNnd>;
	Wed, 7 Aug 2002 09:43:33 -0400
Date: Wed, 7 Aug 2002 09:47:08 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Sergio Avila <sergio@evoto.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel BUG at page_alloc.c:117!
Message-ID: <20020807134708.GA13509@www.kroptech.com>
References: <200208071509.30398.sergio@evoto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208071509.30398.sergio@evoto.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 03:09:08PM +0200, Sergio Avila wrote:
> 
>         kernel BUG at page_alloc.c:117!
> 
>         Aug  7 06:02:30 lordvaider kernel: EIP:    0010:[<c0131107>]    Tainted: P
> 
>         NVdriver             1022272  10 (autoclean)

I'll play Alan for a moment...

Repeat after a cold boot having never loaded the NVidia driver. If you can do so,
repost the results here. Otherwise, contact NVidia since we cannot debug their
closed source driver.

--Adam

