Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263115AbSJBN3c>; Wed, 2 Oct 2002 09:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263116AbSJBN3c>; Wed, 2 Oct 2002 09:29:32 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:57336 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263115AbSJBN3c>; Wed, 2 Oct 2002 09:29:32 -0400
Subject: Re: Swsusp updates, do not thrash ide disk on suspend
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.NEB.4.44.0210021347090.10143-100000@mimas.fachschaften.tu-muenchen.de>
References: <Pine.NEB.4.44.0210021347090.10143-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Oct 2002 14:42:20 +0100
Message-Id: <1033566140.23682.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-02 at 12:49, Adrian Bunk wrote:
> This sounds as if it might makes even ISA cards hot-pluggable with the
> implication that the drivers might need __devinit/__devexit etc.?

This is already true anyway. My IBM thinkpad docking station effectively
has hot pluggable ISA

