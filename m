Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266095AbUALJrT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 04:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266094AbUALJrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 04:47:19 -0500
Received: from smtp-out1.iol.cz ([194.228.2.86]:29378 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S266095AbUALJqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 04:46:49 -0500
Date: Mon, 12 Jan 2004 10:45:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matt Mackall <mpm@selenic.com>
Cc: George Anzinger <george@mvista.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       "Amit S. Kale" <amitkale@emsyssoft.com>
Subject: Re: kgdb cleanups
Message-ID: <20040112094543.GA10869@elf.ucw.cz>
References: <20040109183826.GA795@elf.ucw.cz> <3FFF2304.8000403@mvista.com> <20040110044722.GY18208@waste.org> <3FFFB3D6.1050505@mvista.com> <20040110175607.GH18208@waste.org> <400233A5.8080505@mvista.com> <20040112064923.GX18208@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040112064923.GX18208@waste.org>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > For the internal kgdb stuff I have created kdgb_local.h which I intended to 
> > be local to the workings of kgdb and not to contain anything a user would 
> > need.
> 
> Agreed, I just haven't touched it since you last mentioned it.

I believe we need better name than kgdb_local.h.... Hmm, but I'm not
sure what the name should be.
								Pavel
-- 
When do you have heart between your knees?
