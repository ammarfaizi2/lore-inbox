Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261333AbSJULwE>; Mon, 21 Oct 2002 07:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261335AbSJULwE>; Mon, 21 Oct 2002 07:52:04 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:55219 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261333AbSJULwD>; Mon, 21 Oct 2002 07:52:03 -0400
Subject: Re: [PATCH] work around duff ABIs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: Alexander Viro <viro@math.psu.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021020053147.C5285@parcelfarce.linux.theplanet.co.uk>
References: <20021020053147.C5285@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 13:13:39 +0100
Message-Id: <1035202419.27318.60.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-20 at 05:31, Matthew Wilcox wrote:
> 
> *sigh*.  i hate this kind of bullshit.  please, don't anyone ever try
> to pass 64-bit args through the syscall interface again.

Please bury this crap in arch/hppa/


