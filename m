Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbTDUMia (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 08:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263848AbTDUMia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 08:38:30 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:62424
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263847AbTDUMi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 08:38:29 -0400
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030421131934.1f6e29b0.skraw@ithnet.com>
References: <mail.linux.kernel/20030420185512.763df745.skraw@ithnet.com>
	 <03Apr21.020150edt.41463@gpu.utcc.utoronto.ca>
	 <20030421131934.1f6e29b0.skraw@ithnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050925948.13044.3.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Apr 2003 12:52:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-04-21 at 12:19, Stephan von Krawczynski wrote:
> I can very well accept that argument. What I am trying to do is only make
> _someone_ writing a fs listen to the problem, and maybe - only maybe - in _his_
> fs it is not as complicated and so he simply hacks it in. I am only arguing for
> having a choice. Not more. If e.g. reiserfs had the feature I could simply
> shoot all extX stuff and use my preferred fs all the time. That's just about

You can interest Hans Reiser I'm sure. Just find $100,000.

Its economically saner, better design and a lot more things to just use
md.


