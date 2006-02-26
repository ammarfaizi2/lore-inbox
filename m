Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWBZSWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWBZSWJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 13:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWBZSWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 13:22:08 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:27668 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751376AbWBZSWD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 13:22:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=tIjtdUaQSbWky1ii7nzJ7AH606rJuUFT5mhucisZ7AncZCQ+alpMs1S5gPLqnGeeklD7TCNSzlHiwxjueUKR7qV1tlhUJaPIuEvBkAzFfe5WXMuWw007mvpNBneHTFykZYqRW0FF0TegQ58zFhP730tYNEWSfahuskfM2yu8hq8=
Date: Sun, 26 Feb 2006 19:19:04 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bunk@stusta.de, akpm@osdl.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make UNIX a bool
Message-Id: <20060226191904.974eea0e.diegocg@gmail.com>
In-Reply-To: <44009024.5050105@osdl.org>
References: <20060225160150.GX3674@stusta.de>
	<44009024.5050105@osdl.org>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.8.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sat, 25 Feb 2006 09:13:08 -0800,
Stephen Hemminger <shemminger@osdl.org> escribió:

> Why? You can build unix domain sockets as a loadable module and
> it runs fine (or it did last I tried). Whether that makes sense from a 

I've been running with CONFIG_UNIX=m since the dawn of time and everything
seems to work - not that I care if it's disabled, I just wanted to
confirm that it works.
