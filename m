Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbTIMR3Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 13:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbTIMR3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 13:29:25 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:9739 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262056AbTIMR3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 13:29:23 -0400
Subject: Re: 2.6.0-test5 boot hang with no PS/2 mouse
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: "Kevin P. Fleming" <kpfleming@cox.net>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3F6347D4.9070802@cox.net>
References: <3F6347D4.9070802@cox.net>
Content-Type: text/plain
Message-Id: <1063474160.1297.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 13 Sep 2003 19:29:21 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-09-13 at 18:37, Kevin P. Fleming wrote:
> Booting a kernel the config below, with only a USB keyboard and USB 
> mouse attached, hangs at:
> 
> mice: PS/2 mouse device common for all mice

http://bugzilla.kernel.org/show_bug.cgi?id=1123
Thanks!

