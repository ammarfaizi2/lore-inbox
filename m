Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318133AbSHZRDG>; Mon, 26 Aug 2002 13:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318134AbSHZRDG>; Mon, 26 Aug 2002 13:03:06 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:41981 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318133AbSHZRDF>; Mon, 26 Aug 2002 13:03:05 -0400
Subject: Re: PROBLEM:  conflict between apm and system clock on Inspiron 8100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: mike heffner <mdheffner@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020826170037.69164.qmail@web40210.mail.yahoo.com>
References: <20020826170037.69164.qmail@web40210.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 26 Aug 2002 18:08:45 +0100
Message-Id: <1030381725.1750.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-26 at 18:00, mike heffner wrote:
> Well, isn't that a nice feature.  Is there a
> workaround for this hardware?

A thinkpad ;)

In theory you could try writing some code to measure the elapsed time by
other means and then correct the kernel for the number of lost ticks.
Not trivial. Or for that matter dont run battstat

