Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261370AbSKGSZ3>; Thu, 7 Nov 2002 13:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261374AbSKGSZ2>; Thu, 7 Nov 2002 13:25:28 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:35085
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261370AbSKGSZ2>; Thu, 7 Nov 2002 13:25:28 -0500
Subject: Re: yet another update to the post-halloween doc.
From: Robert Love <rml@tech9.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1021107112618.30525B-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1021107112618.30525B-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Nov 2002 13:18:54 -0500
Message-Id: <1036693135.765.1372.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-07 at 11:33, Bill Davidsen wrote:

>   I don't want to get into politics on this, but wasn't Albert the
> maintainer of procps? I think I saw him state that you guys started
> releasing your own versions instead of sending him patches,

I want to avoid the politics, but real quick...

Michael K. Johnson (yes, that mkj) wrote the current procps package
sometime ago.  With version 2.0.7, development pretty much stopped.

Albert had patches for procps that were not being accepted, so he forked
and put a new tree on SourceForge to continue development.  This is a
good thing, and I do not fault him for it.  But none-the-less it is a
fork.

Rik and I came along, get CVS access to the original tree at Red Hat,
and started development of that.  This tree is what most distributors
include.  So Rik and I are currently maintaining mkj's official tree.

Other than that, I do not care.  Use Albert's tree or ours.  All I care
about is having someone not post to every procps-related email "your
package sucks, use 3.0".

	Robert Love

