Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbTKNSKa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 13:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbTKNSK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 13:10:29 -0500
Received: from palrel11.hp.com ([156.153.255.246]:7853 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262775AbTKNSK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 13:10:29 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16309.6792.579592.780221@napali.hpl.hp.com>
Date: Fri, 14 Nov 2003 10:10:16 -0800
To: Jack Steiner <steiner@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Ravikiran G Thirumalai <kiran@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: hot cache line due to note_interrupt()
In-Reply-To: <20031114174535.GA30388@sgi.com>
References: <20031110215844.GC21632@sgi.com>
	<20031111082915.GC1130@llm08.in.ibm.com>
	<20031111115804.4aaafd28.akpm@osdl.org>
	<20031114174535.GA30388@sgi.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 14 Nov 2003 11:45:35 -0600, Jack Steiner <steiner@sgi.com> said:

  Jack> Probably too late for 2.6.0, but here is a patch that disables
  Jack> noirqdebug:

The ia64-portion looks good to me.  Andrew, if you queue this patch,
please feel free to include the ia64-portion.

Thanks,

	--david
