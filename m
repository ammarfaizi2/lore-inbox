Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262374AbUKBOe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbUKBOe6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 09:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262619AbUKBOZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 09:25:56 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:32278 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262457AbUKBOOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 09:14:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=p3KBt53OIb0UM5dquUL8GAhWALVZQMUWcgDhir2SYnxOpxr71+7auCMhRjY483z/tZSGjpNC8+XXgY292Xg8xGpZb2hxcdhu7ZEAdsrB6dxRjyoAF8yj5HnMmstPevRkIXsMbHVDh+umoL3+3hdycKmRC9ZRamO6IIH4QvnM09w=
Message-ID: <58cb370e04110206142ffb1d11@mail.gmail.com>
Date: Tue, 2 Nov 2004 15:14:32 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Mikael Starvik <mikael.starvik@axis.com>
Subject: Re: [PATCH 4/10] CRIS architecture update - IDE
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C668014C7488@exmail1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <BFECAF9E178F144FAEF2BF4CE739C668014C7488@exmail1.se.axis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It conflicts with changes in 2.6.10-rc1 / current -bk.

On Tue, 2 Nov 2004 14:04:39 +0100, Mikael Starvik
<mikael.starvik@axis.com> wrote:
> Update CRIS IDE driver for 2.6.9.
> 
> Signed-Off-By: starvik@axis.com
> 
> /Mikael
