Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270367AbTGWOtn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 10:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270368AbTGWOtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 10:49:43 -0400
Received: from svr7.m-online.net ([62.245.150.229]:52690 "EHLO
	svr7.m-online.net") by vger.kernel.org with ESMTP id S270367AbTGWOtm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 10:49:42 -0400
Date: Wed, 23 Jul 2003 17:06:57 +0200
From: Florian Huber <florian.huber@mnet-online.de>
To: linux-kernel@vger.kernel.org
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: root= needs hex in 2.6.0-test1-mm2
Message-Id: <20030723170657.2ba9e7db.florian.huber@mnet-online.de>
In-Reply-To: <1058962821.574.0.camel@teapot.felipe-alfaro.com>
References: <200307230156.40762.tcfelker@mtco.com>
	<1058962821.574.0.camel@teapot.felipe-alfaro.com>
X-Mailer: Sylpheed version 0.9.3claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jul 2003 14:20:21 +0200
Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:

> I would say it's a bug :-)

"It's not a bug, it's an undocumented feature" ;)

On the one hand it sounds reasonable tom me that I cannot use the
device "path", because devfs sets it, but why has it changed? It
seemed to work well with older kernel versions. And what do the hex
numbers stand for?

TIA
	Florian Huber

