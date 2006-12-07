Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161735AbWLGRGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161735AbWLGRGo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 12:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032526AbWLGRGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 12:06:43 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40893 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1032546AbWLGRGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 12:06:41 -0500
Date: Thu, 7 Dec 2006 17:14:17 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "Menny Hamburger" <menny@exanet.com>
Cc: "Linux kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: Simple OOM kill protection interface
Message-ID: <20061207171417.27f48c7c@localhost.localdomain>
In-Reply-To: <A6FDE6B975803043804A49F12F49028E0F5588@hawk.exanet-il.co.il>
References: <A6FDE6B975803043804A49F12F49028E0F5588@hawk.exanet-il.co.il>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2006 17:50:55 +0200
"Menny Hamburger" <menny@exanet.com> wrote:

> Hi,
> 
> Following is a rather simple module implementation that adds an interface for protecting against the oom_killer by setting the oomkilladj in the task struct.

NAK

you can adjust it via the /proc entry already.

