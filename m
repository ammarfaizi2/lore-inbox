Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVC2SqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVC2SqL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 13:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVC2SqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 13:46:11 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64420 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261290AbVC2SqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 13:46:01 -0500
Date: Tue, 29 Mar 2005 20:42:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Mister Google <binary-nomad@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Keystroke simulator
Message-ID: <20050329184214.GA7929@elf.ucw.cz>
References: <BAY10-F55DA0F654CE67C2B4DC2F684450@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BAY10-F55DA0F654CE67C2B4DC2F684450@phx.gbl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 29-03-05 11:53:32, Mister Google wrote:
> Is there a way to simulate a keystroke to a program, ie. have a program 
> send it something so that as far as it's concerned, say, the "P" key has 
> been pressed?

See /dev/input/uinput

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
