Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265389AbTLSAjE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 19:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265400AbTLSAjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 19:39:04 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:61826
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S265389AbTLSAjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 19:39:03 -0500
Date: Thu, 18 Dec 2003 19:38:04 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Miroslaw KLABA <totoro@totoro.be>
cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Double Interrupt with HT
In-Reply-To: <1071793964.3fe2472cd2861@ssl0.ovh.net>
Message-ID: <Pine.LNX.4.58.0312181937250.19491@montezuma.fsmlabs.com>
References: <20031215155843.210107b6.totoro@totoro.be>
 <1071603069.991.194.camel@cog.beaverton.ibm.com> <1071615336.3fdf8d6840208@ssl0.ovh.net>
 <1071618630.1013.11.camel@cog.beaverton.ibm.com> <1071630228.3fdfc794eb353@ssl0.ovh.net>
 <1071717730.1117.26.camel@cog.beaverton.ibm.com> <20031218131437.239e69e5.totoro@totoro.be>
 <Pine.LNX.4.58.0312180849480.1710@montezuma.fsmlabs.com>
 <20031218173528.370211b6.totoro@totoro.be> <Pine.LNX.4.58.0312181219570.1710@montezuma.fsmlabs.com>
 <1071793964.3fe2472cd2861@ssl0.ovh.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Dec 2003, Miroslaw KLABA wrote:

> Hello,
>
> This patch doesn't solve the problem.
> `while true; do date; sleep 1; done` still counts twice the speed.

Thanks for entertaining my curiosity, i'll see what else i can dig up.

