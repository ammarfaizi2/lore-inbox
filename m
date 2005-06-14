Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVFNIE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVFNIE3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 04:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVFNIE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 04:04:27 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:896 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261325AbVFNIEV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 04:04:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f2bgljP0Xegjqcrmnzdk1r39wPIsUXPHTpfFwjB7Xf09gnaRmEW/h0j+li35GSyPEkLCr8iphAloKnd+Uxec11ClU2epGipYQrTZ3gyDpUVMmxcnxIQBW2BY3fRVH619Unfk+48aTHumDl57oscDSYL+TAPC7QVevNfO5S4d3so=
Message-ID: <58cb370e05061401041a67cfa7@mail.gmail.com>
Date: Tue, 14 Jun 2005 10:04:20 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alexander Fieroch <Fieroch@web.de>
Subject: Re: [2.6.12rc4] PROBLEM: "drive appears confused" and "irq 18: nobody cared!"
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <429A2397.6090609@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d6gf8j$jnb$1@sea.gmane.org>
	 <20050527171613.5f949683.akpm@osdl.org> <429A2397.6090609@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/05, Alexander Fieroch <Fieroch@web.de> wrote:

> That would be very great. I would like to give you any more information
> that is needed.

dmesg output and .config for a start

Bartlomiej
