Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbTFKV4S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 17:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264516AbTFKV4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 17:56:18 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:38761 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264503AbTFKV4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 17:56:17 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200306112209.h5BM9ub21810@devserv.devel.redhat.com>
Subject: Re: Linux 2.4.21-rc7-ac1
To: duvall@emufarm.org (Danek Duvall)
Date: Wed, 11 Jun 2003 18:09:56 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20030611204828.GC8952@lorien.emufarm.org> from "Danek Duvall" at Meh 11, 2003 01:48:28 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What bits should I start hacking away to narrow down the problem, or is
> this known?

See if its a specific in or out instruction in the rtc driver 

