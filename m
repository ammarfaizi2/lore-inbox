Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272232AbTHNHCA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 03:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272235AbTHNHCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 03:02:00 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:55759 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S272232AbTHNHB5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 03:01:57 -0400
Date: Thu, 14 Aug 2003 09:01:56 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Greg KH <greg@kroah.com>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3-mm2: Badness in class_dev_release at drivers/base/class.c
In-Reply-To: <20030813234220.GB7863@kroah.com>
Message-ID: <Pine.LNX.4.51.0308140900260.11099@dns.toxicfilms.tv>
References: <1060803513.1221.2.camel@teapot.felipe-alfaro.com>
 <20030813234220.GB7863@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a fix for this in my tree, it will get sent to Linus in a few
> days.
>
> thanks for the report.
Great if so, it would resolve bugzilla #1094 & #700.
Both reported by me.

> greg k-h
Maciej

