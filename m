Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266596AbUBRBR6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 20:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267083AbUBRBR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 20:17:58 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:9367
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S266596AbUBRBR5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 20:17:57 -0500
Date: Tue, 17 Feb 2004 20:28:39 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2: "-" or "_", thats the question
Message-ID: <20040217202839.A16590@animx.eu.org>
References: <402A887D.7030408@t-online.de> <402EDBA8.4070102@lovecn.org> <402F42DE.5090308@t-online.de> <20040217184132.541a5a76.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20040217184132.541a5a76.rusty@rustcorp.com.au>; from Rusty Russell on Tue, Feb 17, 2004 at 06:41:32PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> Most users don't want to remember that it's ip_conntrack but uhci-hcd.

I'd like to chime in about this.

I'd prefer it be - all the way around (I know I can use either).  Since I
can ask for module uhci_hcd or uhci-hcd and get uhci-hcd.ko loaded, I've
been using -.  It's a bit easier to type since I don't have to hit shift for
each _

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
