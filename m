Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265130AbUAJLPh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 06:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265150AbUAJLPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 06:15:37 -0500
Received: from [66.62.77.7] ([66.62.77.7]:10397 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S265130AbUAJLPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 06:15:36 -0500
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1
From: Dax Kelson <dax@gurulabs.com>
To: Bart Samwel <bart@samwel.tk>
Cc: linux-kernel@vger.kernel.org, Kiko Piris <kernel@pirispons.net>,
       Bartek Kania <mrbk@gnarf.org>, Simon Mackinlay <smackinlay@mail.com>
In-Reply-To: <3FFFD61C.7070706@samwel.tk>
References: <3FFFD61C.7070706@samwel.tk>
Content-Type: text/plain
Message-Id: <1073733328.2552.1.camel@mentor.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 10 Jan 2004 04:15:29 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-01-10 at 03:38, Bart Samwel wrote:
> I've created a new version of the laptop-mode patch, this time against 
> linux 2.6.1. It can be found here:
> 
> http://www.liacs.nl/~bsamwel/laptop_mode/laptop-mode-2.6.1-7.patch
> 
> It has no kernel code changes, only changes to the supporting 
> documentation/scripts:
> 
> * Dax Kelson's ACPI integration script is included.
> * Fixed a missing "esac" in the control script.
> * Minor documentation improvements.
> 
> Especially Dax's addition should make it a lot more usable. I haven't 
> been able to test this myself however, because I don't own a laptop. Dax 
> probably does, so I'll trust him and assume that he has tested it. ;)

Indeed. 

It works well, I've been using it on my laptop for the past few days.

Dax Kelson
Guru Labs

