Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263105AbSKZXv0>; Tue, 26 Nov 2002 18:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263228AbSKZXv0>; Tue, 26 Nov 2002 18:51:26 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:58771 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263105AbSKZXvZ>; Tue, 26 Nov 2002 18:51:25 -0500
Subject: Re: A Kernel Configuration Tale of Woe
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Otto Wyss <otto.wyss@bluewin.ch>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1fm9ur7.1cv4r4x15rw2waM%otto.wyss@bluewin.ch>
References: <1fm9ur7.1cv4r4x15rw2waM%otto.wyss@bluewin.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Nov 2002 00:29:54 +0000
Message-Id: <1038356994.2658.102.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-26 at 19:59, Otto Wyss wrote:
> IMO each driver should be able (within resonable limits) to detect the
> hardware it is written for, returning a simple true/false.

Dream on

Also there is a GPL library to do the parts of this (and more) that can
be done as part of kudzu.

