Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266135AbUALMuk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 07:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266164AbUALMuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 07:50:40 -0500
Received: from [66.62.77.7] ([66.62.77.7]:8149 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S266135AbUALMuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 07:50:39 -0500
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1
From: Dax Kelson <dax@gurulabs.com>
To: Bart Samwel <bart@samwel.tk>
Cc: Jan De Luyck <lkml@kcore.org>, linux-kernel@vger.kernel.org,
       Kiko Piris <kernel@pirispons.net>, Bartek Kania <mrbk@gnarf.org>,
       Simon Mackinlay <smackinlay@mail.com>
In-Reply-To: <40026FEC.4040707@samwel.tk>
References: <3FFFD61C.7070706@samwel.tk> <200401121045.56749.lkml@kcore.org>
	 <40026FEC.4040707@samwel.tk>
Content-Type: text/plain
Message-Id: <1073911834.2892.0.camel@mentor.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 12 Jan 2004 05:50:34 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-12 at 02:59, Bart Samwel wrote:
> Jan De Luyck wrote:
> > There seems to be a typo in the battery.sh script. It 
> > reads /proc/acpi/ac_adapter/AC/state to determine the AC Adaptor state, but 
> > this is in the ACAD directory instead of the AC directory.
> 
> Hmmm, Dax says it works for him, and I don't have an ac_adapter on my 
> machine because I don't own a laptop. Dax, is this a typo or is it 
> actually called AC on your machine?

On my Dell Inspiron 4150 it is called AC not ACAD.

Dax Kelson
Guru Labs

