Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263304AbUDEVmW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263302AbUDEVVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:21:30 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:37764 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S263280AbUDEVSS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:18:18 -0400
Date: Mon, 5 Apr 2004 23:21:48 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: Re: menuconfig and UTF-8
Message-ID: <20040405212148.GA2387@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040404122426.GA16383@penguin.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040404122426.GA16383@penguin.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2004 at 02:24:26PM +0200, Marcel Sebek wrote:
> Hi.
> 
> I'm using UTF-8 and new changes in Makefile (2.6.5-rc3/2.6.5-final)
> broke using menuconfig on linux console (xterm works ok).

Could you please explain how it 'broke' menuconfig.
It works for me, but I have no fancy locale setup.

Thanks,
	Sam
