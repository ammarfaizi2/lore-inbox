Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932636AbVJ2WZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbVJ2WZT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 18:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932644AbVJ2WZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 18:25:19 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56041 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932636AbVJ2WZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 18:25:17 -0400
Date: Sun, 30 Oct 2005 00:25:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@osdl.org
Subject: Re: [RFC][PATCH 1/6] swsusp: rework swsusp_suspend
Message-ID: <20051029222500.GB14209@elf.ucw.cz>
References: <200510292158.11089.rjw@sisk.pl> <200510292201.05724.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510292201.05724.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is a preliminary step.  It makes only the functions in swsusp.c call
> functions in snapshot.c and not both ways.  Basically, it moves the code
> without changing its functionality.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK, nice.
								Pavel
-- 
Thanks, Sharp!
