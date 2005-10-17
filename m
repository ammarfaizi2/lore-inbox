Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbVJQX4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbVJQX4W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 19:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbVJQX4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 19:56:21 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:62871 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751417AbVJQX4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 19:56:21 -0400
Date: Tue, 18 Oct 2005 01:56:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 4/4] swsusp: reduce the use of global variables
Message-ID: <20051017235620.GD13148@atrey.karlin.mff.cuni.cz>
References: <200510172336.53194.rjw@sisk.pl> <200510180013.18967.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510180013.18967.rjw@sisk.pl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The following patch reduces the use of global variables in the
> snapshot-handling part of swsusp, snapshot.c.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.
							Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.
