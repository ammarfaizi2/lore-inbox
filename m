Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264736AbSJUEvZ>; Mon, 21 Oct 2002 00:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264737AbSJUEvZ>; Mon, 21 Oct 2002 00:51:25 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:12797 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S264736AbSJUEvZ> convert rfc822-to-8bit; Mon, 21 Oct 2002 00:51:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: ck performance patchset for 2.4.19 broken out as ck10
Date: Sun, 20 Oct 2002 18:57:28 -0500
User-Agent: KMail/1.4.3
References: <200210200005.08444.conman@kolivas.net>
In-Reply-To: <200210200005.08444.conman@kolivas.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210201857.28851.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 October 2002 09:05, Con Kolivas wrote:
> Hi
>
> My merged performance patchset (-ck) containing
>
> O(1) + batch scheduling
> Preemptible
> Low Latency
> Compressed Caching or
> AA VM addons
> XFS
> ALSA
> Supermount

I don't see compressed caching on the 2.5 status list.  I take it this patch 
was never ported to 2.5?

Rob

