Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268727AbTCCTV3>; Mon, 3 Mar 2003 14:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268729AbTCCTV3>; Mon, 3 Mar 2003 14:21:29 -0500
Received: from air-2.osdl.org ([65.172.181.6]:12972 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268727AbTCCTV2>;
	Mon, 3 Mar 2003 14:21:28 -0500
Date: Mon, 3 Mar 2003 11:26:32 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: hch@infradead.org, andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5-bk menuconfig format problem
Message-Id: <20030303112632.7cb3e4bd.rddunlap@osdl.org>
In-Reply-To: <20030303192245.GH6946@louise.pinerecords.com>
References: <3E637196.8030708@walrond.org>
	<20030303175844.A29121@infradead.org>
	<20030303184906.GF6946@louise.pinerecords.com>
	<20030303185337.A30585@infradead.org>
	<20030303191908.GA3609@mars.ravnborg.org>
	<20030303192245.GH6946@louise.pinerecords.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Mar 2003 20:22:45 +0100
Tomas Szepe <szepe@pinerecords.com> wrote:

| > [sam@ravnborg.org]
| > 
| > On Mon, Mar 03, 2003 at 06:53:37PM +0000, Christoph Hellwig wrote:
| > > Ah, okay :)  I newer use either menuconfig nor xconfig so I can't comment
| > > on it's placements.  If people who actually do use if feel that it's placed
| > > wrongly feel free to submit a patch to fix it.
| > 
| > The following patch moves it to the menu "Processor type & features"
| > Right before HIMEM.
| 
| Please don't do this.  While HIMEM could still be perceived as a processor
| (architecture) feature, SWAP certainly doesn't qualify.  We already have
| enough misplaced options.

Also makes no sense to me in Processor types & features.

--
~Randy
