Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262795AbSJaQQf>; Thu, 31 Oct 2002 11:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262791AbSJaQQf>; Thu, 31 Oct 2002 11:16:35 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:18822 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262795AbSJaQQ3>; Thu, 31 Oct 2002 11:16:29 -0500
Subject: RE: Kernel bug in 2.4.7-10smp...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adriano Galano <adriano@satec.es>
Cc: "'LKML'" <linux-kernel@vger.kernel.org>
In-Reply-To: <002101c280f4$1e91c380$6f20a4d5@adriano>
References: <002101c280f4$1e91c380$6f20a4d5@adriano>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 31 Oct 2002 16:42:57 +0000
Message-Id: <1036082577.8575.77.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-31 at 15:42, Adriano Galano wrote:
> I don't apply the patches for possible incompatibility with Compaq Remote
> Insight Manager card, the drivers of this card are for 2.4.7
> (http://www.compaq.com/support/files/server/us/download/15084.html). Now I'm
> trying to make one upgrade to 2.4.18 recompiling the drivers source...  Why
> happen this errors in 2.4.7?

2.4.7 had various bugs that got fixed, like any other software. The old
kernel you are running also has security holes fixed which is a very
good reason to upgrade

