Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264163AbUBHV7k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 16:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264229AbUBHV7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 16:59:39 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:20703 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264163AbUBHV7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 16:59:38 -0500
Date: Sun, 8 Feb 2004 22:59:35 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Murilo Pontes <murilo_pontes@yahoo.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: psmouse.c, throwing 3 bytes away
Message-ID: <20040208215935.GA13280@ucw.cz>
References: <200402041820.39742.wnelsonjr@comcast.net> <200402060006.32732.wnelsonjr@comcast.net> <20040207004700.0dd5e626.mikeserv@bmts.com> <200402070911.42569.murilo_pontes@yahoo.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402070911.42569.murilo_pontes@yahoo.com.br>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 09:11:42AM +0000, Murilo Pontes wrote:

> Problem still occurs :-(

I have good news - I've managed to reliably reproduce the bug on my
machine and that means I now have a good chance to find and fix it.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
