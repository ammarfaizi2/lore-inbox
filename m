Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318237AbSGQHl3>; Wed, 17 Jul 2002 03:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318238AbSGQHl2>; Wed, 17 Jul 2002 03:41:28 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:41973 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318237AbSGQHl2>; Wed, 17 Jul 2002 03:41:28 -0400
Subject: Re: A kernel bug of sorts...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Schaper <schaper@inet.net.nz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000501c22d48$e6940230$0200a8c0@john>
References: <000501c22d48$e6940230$0200a8c0@john>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 17 Jul 2002 09:54:53 +0100
Message-Id: <1026896093.2119.124.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-17 at 05:17, John Schaper wrote:
> Just a quick note... it appears that "i2c-old.h" has been omitted from the
> 2.5.25 kernel source (tar.bz2).

This is intentional to encourage people to finish porting to the newer
i2c code

