Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264927AbSJVUNa>; Tue, 22 Oct 2002 16:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264849AbSJVUMk>; Tue, 22 Oct 2002 16:12:40 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:1979 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264903AbSJVULo>; Tue, 22 Oct 2002 16:11:44 -0400
Subject: Re: [STATUS 2.5]  October 21, 2002
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Rob Landley <landley@trommello.org>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Roman Zippel <zippel@linux-m68k.org>, riel@conectiva.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       akpm@zip.com.au, davem@redhat.com, mingo@redhat.com
In-Reply-To: <20021022195730.GA30958@suse.de>
References: <20021021135137.2801edd2.rusty@rustcorp.com.au>
	<3DB3AB3E.23020.5FFF7144@localhost>
	<200210211522.35843.landley@trommello.org>
	<20021022194739.GB28822@clusterfs.com>  <20021022195730.GA30958@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 21:33:15 +0100
Message-Id: <1035318795.329.147.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 20:57, Dave Jones wrote:
> Nevertheless, it means any ext3 stability testing done post-freeze
> would be invalidated by addition of a new _feature_.

No serious ext3 testing done so far is worth anything anyway. Im pretty
sure ext3 resize will beat driver code that passes cerberus reliably..

