Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424064AbWKIPeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424064AbWKIPeJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 10:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424065AbWKIPeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 10:34:09 -0500
Received: from ns2.suse.de ([195.135.220.15]:44752 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1424064AbWKIPeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 10:34:08 -0500
From: Andi Kleen <ak@suse.de>
To: Alexander van Heukelum <heukelum@mailshack.com>
Subject: Re: [PATCH] shorten the x86_64 boot setup GDT to what the comment says
Date: Thu, 9 Nov 2006 14:33:08 +0100
User-Agent: KMail/1.9.1
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
       sct@redhat.com, herbert@gondor.apana.org.au,
       xen-devel@lists.xensource.com
References: <Pine.LNX.4.58.0611082144410.17812@gandalf.stny.rr.com> <Pine.LNX.4.58.0611091016100.6250@gandalf.stny.rr.com> <20061109154436.GA31954@mailshack.com>
In-Reply-To: <20061109154436.GA31954@mailshack.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611091433.09232.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Maybe you should consider 16-byte aligning the gdt table too, like
> i386 does? It doesn't hurt, and as per the comment in the i386-file
> "16 byte aligment is recommended by intel."

It already is.

-Andi

