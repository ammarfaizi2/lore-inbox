Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262577AbSI0SUo>; Fri, 27 Sep 2002 14:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262578AbSI0SUo>; Fri, 27 Sep 2002 14:20:44 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:42742 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262577AbSI0SUn>; Fri, 27 Sep 2002 14:20:43 -0400
Subject: Re: [patch] stradis fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: laredo@gnu.org, linux-kernel@vger.kernel.org
In-Reply-To: <20020927172230.GQ20649@cathedrallabs.org>
References: <20020927172230.GQ20649@cathedrallabs.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Sep 2002 18:55:32 +0100
Message-Id: <1033149332.16726.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-27 at 18:22, Aristeu Sergio Rozanski Filho wrote:
> hi,
> 	this patch makes stradis driver uses struct file_operations (struct
> video_device changed).
> 

What are all the (void *) casts you added supposed to be for ?


