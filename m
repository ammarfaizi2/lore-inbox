Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbTJ0VpY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 16:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbTJ0VpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 16:45:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:6047 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263607AbTJ0VpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 16:45:23 -0500
Date: Mon, 27 Oct 2003 13:53:42 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: David Ford <david+powerix@blue-labs.org>
cc: John Mock <kd6pag@qsl.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test9 suspend problems
In-Reply-To: <3F9D875E.8020302@blue-labs.org>
Message-ID: <Pine.LNX.4.44.0310271352560.13116-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Unfortunately I use USB mostly for my digital camera.  Losing sound is 
> pretty annoying too because everything that tries to play sound then 
> gets into D state as well.

That would most likely be due to your sound driver not supporting 
suspend/reusme. Which sound driver are you using? 

Thanks,


	Pat

