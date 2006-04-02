Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWDBKle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWDBKle (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 06:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWDBKle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 06:41:34 -0400
Received: from tim.rpsys.net ([194.106.48.114]:36332 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932278AbWDBKld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 06:41:33 -0400
Subject: Re: [LEDS] fix IDE disk trigger name
From: Richard Purdie <rpurdie@rpsys.net>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: Ben Dooks <ben-linux@fluff.org>
In-Reply-To: <20060401152941.GA11333@home.fluff.org>
References: <20060401152941.GA11333@home.fluff.org>
Content-Type: text/plain
Date: Sun, 02 Apr 2006 11:41:21 +0100
Message-Id: <1143974482.6423.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-01 at 16:29 +0100, Ben Dooks wrote:
> The IDE Disk LED trigger has the same name
> as the timer trigger.
> 
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Acked-by: Richard Purdie <rpurdie@rpsys.net>

