Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262326AbSKYCQj>; Sun, 24 Nov 2002 21:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262363AbSKYCQi>; Sun, 24 Nov 2002 21:16:38 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:38416
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262326AbSKYCQi>; Sun, 24 Nov 2002 21:16:38 -0500
Subject: Re: Which embedded linux is better for being a router? eCos?
	uclinux?
From: Robert Love <rml@tech9.net>
To: paul_wu@wnexus.com.tw
Cc: Tommy Reynolds <reynolds@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <48256C7C.0005853D.00@TWHSZDS1.WISTRON.COM.TW>
References: <48256C7C.0005853D.00@TWHSZDS1.WISTRON.COM.TW>
Content-Type: text/plain
Organization: 
Message-Id: <1038191030.776.67.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 24 Nov 2002 21:23:50 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-24 at 20:01, paul_wu@wnexus.com.tw wrote:

> CPU will be MIPS. Does uclinux support multi-processes? Or there
> is 3rd choice for such embedded Linux?

You do not need any special version of Linux.  Your chip has an MMU and
all the other normal bits.  Just compile up a stock kernel and
user-land.

If you want an already-done distribution, there are a few out there -
google around.  Commercial offerings are available from MontaVista, Red
Hat, etc, too.

	Robert Love

