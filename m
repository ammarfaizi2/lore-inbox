Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932689AbVJ2W2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689AbVJ2W2E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 18:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbVJ2W2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 18:28:03 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38538 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932689AbVJ2W2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 18:28:02 -0400
Date: Sun, 30 Oct 2005 00:27:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@osdl.org
Subject: Re: [RFC][PATCH 2/6] swsusp: move snapshot-handling functions to snapshot.c
Message-ID: <20051029222748.GC14209@elf.ucw.cz>
References: <200510292158.11089.rjw@sisk.pl> <200510292206.23166.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510292206.23166.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 29-10-05 22:06:22, Rafael J. Wysocki wrote:
> This is another preliminary step.  It moves the snapshot-handling functions
> remaining in swsusp.c to snapshot.c (moving the code without changing
> the functionality) and makes the next patch be more clear (in my opinion).
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK and thanks.
								Pavel
-- 
Thanks, Sharp!
