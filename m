Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268005AbUJJBUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268005AbUJJBUJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 21:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268024AbUJJBUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 21:20:09 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:28778 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268005AbUJJBUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 21:20:06 -0400
Message-ID: <35fb2e590410091820c27bcd@mail.gmail.com>
Date: Sun, 10 Oct 2004 02:20:06 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: [PATCH] make automounter runnable in foreground and add stderr logging
Cc: raven@themaw.net, valdis.kletnieks@vt.edu,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200410092246.01429.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200410072049.18059.vda@port.imtp.ilyichevsk.odessa.ua>
	 <200410071817.i97IHnPZ017247@turing-police.cc.vt.edu>
	 <Pine.LNX.4.58.0410091021240.1370@donald.themaw.net>
	 <200410092246.01429.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Oct 2004 22:46:01 +0300, Denis Vlasenko 

> Can we stick to standard method of using $PATH? Please, pretty please.

That'll break some backwards compatibility - probably just go with a
command flag to do that.

Jon.
