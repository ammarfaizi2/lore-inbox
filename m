Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268199AbUIPPfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268199AbUIPPfQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 11:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268209AbUIPPfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 11:35:10 -0400
Received: from smtp.terra.es ([213.4.129.129]:2765 "EHLO tsmtp4.mail.isp")
	by vger.kernel.org with ESMTP id S268191AbUIPPez convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 11:34:55 -0400
Date: Thu, 16 Sep 2004 17:33:52 +0200
From: Diego Calleja <diegocg@teleline.es>
To: Alan Cox <alan@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: tty drivers take two
Message-Id: <20040916173352.160372f4.diegocg@teleline.es>
In-Reply-To: <20040916143057.GA15163@devserv.devel.redhat.com>
References: <20040916143057.GA15163@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 16 Sep 2004 10:30:57 -0400 Alan Cox <alan@redhat.com> escribió:

> - Fix refcount init bug found by Paul Fulghum
> 	(should fix pppd)

I can confirm it fixes the problem I reported for -rc2-mm1.
