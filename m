Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVCUAjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVCUAjV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 19:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVCUAjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 19:39:21 -0500
Received: from fire.osdl.org ([65.172.181.4]:21227 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261345AbVCUAjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 19:39:19 -0500
Date: Sun, 20 Mar 2005 16:39:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Patrick McFarland <pmcfarland@downeast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: alsa es1371's joystick functionality broken in 2.6.11-mm4
Message-Id: <20050320163900.75f30a9f.akpm@osdl.org>
In-Reply-To: <200503201557.58055.pmcfarland@downeast.net>
References: <200503201557.58055.pmcfarland@downeast.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McFarland <pmcfarland@downeast.net> wrote:
>
> It seems that the es1371 driver (which provides its own joystick port driver) 
> is broken in at least 2.6.11-mm4. I don't know when it broke, but it used to 
> work around in the 2.6.8/9 days (I haven't used the joystick in awhile). The 
> hardware and joystick still both work (tested in Windows).
> 

Please define "broken".  I assume that audio still comes out, but that the
joystick doesn't work?

