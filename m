Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWETPuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWETPuv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 11:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWETPuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 11:50:51 -0400
Received: from [63.81.120.158] ([63.81.120.158]:55698 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751312AbWETPuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 11:50:50 -0400
Subject: Re: [PATCH -rt] show_held_locks cleanup
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200605121712.k4CHCHXG011893@dwalker1.mvista.com>
References: <200605121712.k4CHCHXG011893@dwalker1.mvista.com>
Content-Type: text/plain
Date: Sat, 20 May 2006 08:50:48 -0700
Message-Id: <1148140248.3535.67.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You didn't like this one ?


On Fri, 2006-05-12 at 10:12 -0700, Daniel Walker wrote:
>  - turns show_held_locks into debug_mutex_show_held_locks() . 
>  - Adds debug_mutex_show_held_locks() + rt_mutex_show_held_locks() to x86_64
>  - cleans up show_held_locks() on arm .
> 
> I compile tested i386, arm, not x86_64 . Seems like this should go upstream too.
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>


