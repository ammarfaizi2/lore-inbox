Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVFTHOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVFTHOX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 03:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVFTHOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 03:14:22 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:38002 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261166AbVFTHOU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 03:14:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BX2cgFtTR57w7ui9PgE2xxV8UL2dIttHLDmUWl22m/Kzp2841FaBVon/HRk2cxCIXrr6qhGVGMFqjwytaFpkBYI6iuXGN89vy1MbQS9MQV6A/ZYZLOCUKoZjUeOIre2rLcMn6RtWQmvN62ig7T1k8ff+H6uwXFjiZdZ+jWQ1d7E=
Message-ID: <b82a891705062000144a0c3f81@mail.gmail.com>
Date: Mon, 20 Jun 2005 12:44:20 +0530
From: Niraj kumar <niraj17@gmail.com>
Reply-To: niraj17@iitbombay.org
To: guorke <gourke@gmail.com>
Subject: Re: Hi,make question
Cc: Bongani Hlope <bonganilinux@mweb.co.za>, linux-kernel@vger.kernel.org
In-Reply-To: <d73ab4d005061922314a2cadb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d73ab4d005061918441ae4a81f@mail.gmail.com>
	 <200506200618.44344.bonganilinux@mweb.co.za>
	 <d73ab4d005061922314a2cadb5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/05, guorke <gourke@gmail.com> wrote:
> > 1. What kernel are you currently runnig
<snip>
> I meet lot of  Segmentation fault.
> So I must make again and agian.

Continuous segfault is usually sign of a hardware/memory issue .

You may like to try memtest86 .

Niraj
