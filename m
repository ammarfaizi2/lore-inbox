Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263474AbTIAStg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 14:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbTIAStg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 14:49:36 -0400
Received: from 213-0-202-50.dialup.nuria.telefonica-data.net ([213.0.202.50]:55693
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S263474AbTIASte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 14:49:34 -0400
Date: Mon, 1 Sep 2003 20:49:28 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Nico Schottelius <nico-kernel@schottelius.org>, bastian@schottelius.org
Subject: Re: [BUGS?: 2.6.0test4] iptables and tc problems
Message-ID: <20030901184928.GA3585@localhost>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Nico Schottelius <nico-kernel@schottelius.org>,
	bastian@schottelius.org
References: <20030901122818.GE5524@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901122818.GE5524@schottelius.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 01 September 2003, at 14:28:18 +0200,
Nico Schottelius wrote:

> When running qos-neu (http://schotteli.us/~nico/qos-neu) dmesg says:
> HTB init, kernel part version 3.13
> HTB: quantum of class 10010 is small. Consider r2q change.
>
This is a known informative message from HTB, whose meaning and way to
solve you can find at lartc mailing list archives, or at
http://docum.org

Regards,

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test4-mm4)
