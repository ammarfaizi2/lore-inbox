Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbTJ3VHl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 16:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbTJ3VHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 16:07:41 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:5570 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262874AbTJ3VHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 16:07:40 -0500
Subject: Re: [Lse-tech] Re: 2.6.0-test9-mjb1
From: Dave Hansen <haveblue@us.ibm.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
In-Reply-To: <3FA171DD.5060406@pobox.com>
References: <14860000.1067544022@flay>  <3FA171DD.5060406@pobox.com>
Content-Type: text/plain
Organization: 
Message-Id: <1067548047.1028.19.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 30 Oct 2003 13:07:27 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-30 at 12:17, Jeff Garzik wrote:
> Martin J. Bligh wrote:
> > e1000 fixes
> Um...   any e1000 fixes you have, please forward them to me and Intel 
> rather than letting them languish in a tree.

There aren't any in there right now.  The patches that Martin is
referring to were probably a couple from Anton that got fixed and merged
long, long ago.  There's one that we keep around for ppc64, but it's not
applicable to any other architectures and it's not really mainline
material anyway.  

I think Martin needs to update his list.
-- 
Dave Hansen
haveblue@us.ibm.com

