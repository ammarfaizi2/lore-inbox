Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261223AbSKGPKs>; Thu, 7 Nov 2002 10:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261224AbSKGPKs>; Thu, 7 Nov 2002 10:10:48 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:22257 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261223AbSKGPKr>; Thu, 7 Nov 2002 10:10:47 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.44.0211050414410.27141-100000@montezuma.mastecende.com> 
References: <Pine.LNX.4.44.0211050414410.27141-100000@montezuma.mastecende.com> 
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45 odd deref in serial_in 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 07 Nov 2002 15:17:14 +0000
Message-ID: <13624.1036682234@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


zwane@holomorphy.com said:
>  I'm runnning 115200 :P 

Why so slow? Most current chipsets can do at least 230400, usually 460800.

--
dwmw2


