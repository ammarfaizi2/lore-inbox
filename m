Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262612AbVDYN7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbVDYN7r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 09:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVDYN7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 09:59:47 -0400
Received: from palrel11.hp.com ([156.153.255.246]:49062 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262612AbVDYN7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 09:59:46 -0400
Date: Mon, 25 Apr 2005 15:56:03 +0200
From: Torben Mathiasen <torben.mathiasen@hp.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Atro.Tossavainen@helsinki.fi, torben.mathiasen@compaq.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux kernel TI TLAN driver
Message-ID: <20050425135603.GD7617@linux2>
References: <200504220800.j3M80GSL006528@kruuna.helsinki.fi> <1114428275.18355.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114428275.18355.7.camel@localhost.localdomain>
X-OS: Linux 2.6.5-7.111-default 
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25 2005, Alan Cox wrote:
> Try with 2.6.x - I'm not sure the 64bit cleanness stuff ever all got
> into the 2.4 driver version. 

Yeah the 2.6 version is your best bet. Allthough, I haven't tried it on an
Alpha in a long time.

BTW. I'm not maintaining the driver anymore. Samuel Chessman (chessman@tux.org)
took over maintainership, but I'm not sure if he's still active.

Torben
