Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVATHnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVATHnG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 02:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbVATHnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 02:43:06 -0500
Received: from smtp.mailbox.co.uk ([195.82.125.32]:8349 "EHLO
	smtp.mailbox.co.uk") by vger.kernel.org with ESMTP id S261942AbVATHmu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 02:42:50 -0500
Message-ID: <1065.192.168.1.113.1106206839.squirrel@pat.int.jonmasters.org>
Date: Thu, 20 Jan 2005 07:40:39 -0000 (GMT)
Subject: Re: [Lists-linux-kernel-news] Re: [PATCH] raid6: altivec support
From: "Jon Masters" <jonathan@jonmasters.org>
To: <benh@kernel.crashing.org>
In-Reply-To: <1106177129.5327.43.camel@gaston>
References: <1106120622.10851.42.camel@baythorne.infradead.org>
        <BD84893E-6A28-11D9-AC28-000393DBC2E8@freescale.com>
        <1106146083.26551.526.camel@hades.cambridge.redhat.com>
        <1106177129.5327.43.camel@gaston>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <dwmw2@infradead.org>, <linuxppc-dev@ozlabs.org>, <torvalds@osdl.org>,
       <paulus@samba.org>, <olh@suse.de>, <jonathan@jonmasters.org>,
       <kumar.gala@freescale.com>, <hpa@zytor.com>,
       <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[excuse formatting, adhoc connectivity]


Ben writes:


> And ppc64 adds a flattened device-tree format, even better imho :)


This is exactly what I was looking at - pulling that in to ppc32, helps
with stuff like kexec too. Like everything else, it helps to have people
moaning at me to make me get on with it :-) I'll see if I can't spend a
few hours on the plane and ressurrect this instead of window gazing.

Jon.



