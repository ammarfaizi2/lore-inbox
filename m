Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbVDGLRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbVDGLRg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 07:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262428AbVDGLRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 07:17:35 -0400
Received: from ozlabs.org ([203.10.76.45]:50822 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262421AbVDGLRe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 07:17:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16981.5848.541897.154348@cargo.ozlabs.ibm.com>
Date: Thu, 7 Apr 2005 21:17:44 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: dwmw2@infradead.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
In-Reply-To: <20050407024605.35515dcc.akpm@osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	<1112858331.6924.17.camel@localhost.localdomain>
	<20050407015019.4563afe0.akpm@osdl.org>
	<16980.64324.87931.513333@cargo.ozlabs.ibm.com>
	<20050407024605.35515dcc.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> >  The other reason,
> >  of course, is to be able to see if a patch I'm about to send conflicts
> >  with something you have already taken, and rebase it if necessary.
> 
> <hack, hack>
> 
> How's this?

Nice; but in fact I meant that I want to be able to see if a patch of
mine conflicts with one from somebody else.

Paul.
