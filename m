Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWDBKog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWDBKog (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 06:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWDBKog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 06:44:36 -0400
Received: from tim.rpsys.net ([194.106.48.114]:42476 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932311AbWDBKog (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 06:44:36 -0400
Subject: Re: [RFC] [LEDS] reorganise Kconfig
From: Richard Purdie <rpurdie@rpsys.net>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Cc: Ben Dooks <ben-linux@fluff.org>
In-Reply-To: <20060401154246.GA11649@home.fluff.org>
References: <20060401154246.GA11649@home.fluff.org>
Content-Type: text/plain
Date: Sun, 02 Apr 2006 11:44:21 +0100
Message-Id: <1143974661.6423.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-01 at 16:42 +0100, Ben Dooks wrote:
> This patch reorganises the drivers/leds Kconfig
> file to have the LED trigger enable with the
> triggers themselves.
> 
> The patch also adds comments to divide up the
> sections into the drivers and triggers
> 
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Acked-by: Richard Purdie <rpurdie@rpsys.net>

