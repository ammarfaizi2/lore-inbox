Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264382AbUEMSbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbUEMSbQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 14:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbUEMSbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 14:31:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:50592 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264382AbUEMSbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 14:31:15 -0400
Date: Thu, 13 May 2004 11:30:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: michal@logix.cz, jmorris@redhat.com, davem@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Support for VIA PadLock crypto engine
Message-Id: <20040513113028.085194a3.akpm@osdl.org>
In-Reply-To: <40A37118.ED58E781@users.sourceforge.net>
References: <Xine.LNX.4.44.0405120933010.10943-100000@thoron.boston.redhat.com>
	<Pine.LNX.4.53.0405121546200.24118@maxipes.logix.cz>
	<40A37118.ED58E781@users.sourceforge.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jari Ruusu <jariruusu@users.sourceforge.net> wrote:
>
>  The cryptoloop implementation is busted in more than one way, so it is
>  useless for security needs:

Is dm-crypt any better?
