Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263387AbTDYSKf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 14:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263488AbTDYSKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 14:10:34 -0400
Received: from air-2.osdl.org ([65.172.181.6]:54489 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263387AbTDYSKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 14:10:34 -0400
Date: Fri, 25 Apr 2003 11:20:42 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: bcrl@redhat.com, akpm@digeo.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.68-mm2
Message-Id: <20030425112042.37493d02.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.3.96.1030425135538.16623C-100000@gatekeeper.tmr.com>
References: <20030424163334.A12180@redhat.com>
	<Pine.LNX.3.96.1030425135538.16623C-100000@gatekeeper.tmr.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Apr 2003 13:56:31 -0400 (EDT) Bill Davidsen <davidsen@tmr.com> wrote:

| On Thu, 24 Apr 2003, Benjamin LaHaise wrote:
| 
| > On Thu, Apr 24, 2003 at 04:24:56PM -0400, Bill Davidsen wrote:
| > > Of course reasonable way may mean that bash does some things a bit slower,
| > > but given that the whole thing works well in most cases anyway, I think
| > > the kernel handling the situation is preferable.
| > 
| > Eh?  It makes bash _faster_ for all cases of starting up a child process.  
| > And it even works on 2.4 kernels.
| 
| The point is that even if bash is fixed it's desirable to address the
| issue in the kernel, other applications may well misbehave as well.

So when would this ever end?

--
~Randy
