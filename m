Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWHAWCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWHAWCi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 18:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWHAWCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 18:02:38 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59529 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751205AbWHAWCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 18:02:38 -0400
Subject: Re: remove null chars from dvb names
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060801200550.GA22240@redhat.com>
References: <20060801200550.GA22240@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 01 Aug 2006 23:21:50 +0100
Message-Id: <1154470910.15540.97.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-01 am 16:05 -0400, ysgrifennodd Dave Jones:
> DVB null terminates its device names, which seems odd, and should
> be unnecessary.

Acked-by: Alan Cox <alan@redhat.com>

