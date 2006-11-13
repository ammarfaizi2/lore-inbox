Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755156AbWKMQsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755156AbWKMQsP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755192AbWKMQsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:48:15 -0500
Received: from ns2.suse.de ([195.135.220.15]:41431 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1755156AbWKMQsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:48:14 -0500
From: Andi Kleen <ak@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] make x86_64 boot gdt size exact (like x86).
Date: Mon, 13 Nov 2006 17:47:57 +0100
User-Agent: KMail/1.9.5
Cc: Alexander van Heukelum <heukelum@mailshack.com>,
       LKML <linux-kernel@vger.kernel.org>, sct@redhat.com,
       herbert@gondor.apana.org.au, xen-devel@lists.xensource.com
References: <Pine.LNX.4.58.0611082144410.17812@gandalf.stny.rr.com> <200611110742.53632.ak@suse.de> <Pine.LNX.4.58.0611131037050.17168@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0611131037050.17168@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611131747.57821.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Do you have the exact patch that you applied somewhere public?  A git repo
> or something. I'd like to match what will be going upstream exactly.


ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/fix-boot-gdt-limit

But I still need to add the - 1 ... Will be up soon

-Andi
