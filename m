Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWBXPDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWBXPDM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 10:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWBXPDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 10:03:12 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:2728 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932228AbWBXPDK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 10:03:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dQsc84tS88VcqsjZZ9yX3Qgzaeu+5lUR5WiRagFgrWFzeX1yFf2byy6w8HJLi5FMoUMUelO20TtR+BpjbqXNuUEzC1sRqWsRTv88Eaz3Vwy9IgUBaYvvvJ9W5ts0Yu+8JLUp7MNn9DCwaYUi7OL2ZFnmuKHT3WgjBnBPgwGFWwY=
Message-ID: <5be025980602240703w30a9581bm4fe8ccf9cbc80076@mail.gmail.com>
Date: Fri, 24 Feb 2006 10:03:04 -0500
From: "Wei Hu" <glegoo@gmail.com>
To: "Rogan Dawes" <discard@dawes.za.net>
Subject: Re: Looking for a file monitor
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43FEC9EC.7080902@dawes.za.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5be025980602232351k3f6182bbqed5ea54079193953@mail.gmail.com>
	 <43FEC9EC.7080902@dawes.za.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> It looks to me like you could use an LD_PRELOAD'ed library to monitor
> such events?

That's a good idea.
Is there an existing tool, or do I need to write a system call wrapper?

>
> Alternatively, consider something like the honeynet monitoring kernel
> monitor module, perhaps.

Could you give more information here?
I'm not familiar with honeynet, thanks.

>
> Rogan
>
