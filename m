Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268306AbUHKXBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268306AbUHKXBk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 19:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268292AbUHKW6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 18:58:19 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:49538 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S268318AbUHKW5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 18:57:14 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Diffie <diffie@gmail.com>
Subject: Re: 2.6.8-rc4-mm1
Date: Wed, 11 Aug 2004 16:57:10 -0600
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <9dda349204081020337de13352@mail.gmail.com>
In-Reply-To: <9dda349204081020337de13352@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408111657.10923.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.6.8-rc4-mm1 panics when booting (aic7xxx) with lots of SCSI ABORT
> and sens code errors.
> IDE ports give also failed probe messages.

If you could capture the output of the failed kernel, that would be
helpful.  I know that's a pain unless you're using a serial console.
Thanks!

Bjorn
