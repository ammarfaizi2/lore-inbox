Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUG1UiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUG1UiJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 16:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbUG1UiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 16:38:08 -0400
Received: from ozlabs.org ([203.10.76.45]:51106 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263664AbUG1UiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 16:38:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16648.3689.152017.994106@cargo.ozlabs.ibm.com>
Date: Wed, 28 Jul 2004 15:36:57 -0500
From: Paul Mackerras <paulus@samba.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Ryan Arnold <rsa@us.ibm.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [announce][draft3] HVCS for inclusion in 2.6 tree
In-Reply-To: <20040728131257.1fedf56d.rddunlap@osdl.org>
References: <1089819720.3385.66.camel@localhost>
	<16633.55727.513217.364467@cargo.ozlabs.ibm.com>
	<1090528007.3161.7.camel@localhost>
	<20040722191637.52ab515a.akpm@osdl.org>
	<1090958938.14771.35.camel@localhost>
	<20040727155011.77897e68.rddunlap@osdl.org>
	<1091032768.14771.283.camel@localhost>
	<20040728131257.1fedf56d.rddunlap@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap writes:

> OK, you made me look.  Most of that header file is reasonable except
> for that set of #defines (IMO of course).

I think that being consistent with the external documentation is
useful and worth the (relatively minor) ugliness of the names.

Paul.
