Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268728AbTCCTKE>; Mon, 3 Mar 2003 14:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268729AbTCCTKE>; Mon, 3 Mar 2003 14:10:04 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:10250 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S268728AbTCCTKB>; Mon, 3 Mar 2003 14:10:01 -0500
Date: Mon, 3 Mar 2003 19:20:27 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>, Tomas Szepe <szepe@pinerecords.com>,
       Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.5-bk menuconfig format problem
Message-ID: <20030303192026.A30820@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tomas Szepe <szepe@pinerecords.com>,
	Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
References: <3E637196.8030708@walrond.org> <20030303175844.A29121@infradead.org> <20030303184906.GF6946@louise.pinerecords.com> <20030303185337.A30585@infradead.org> <20030303191908.GA3609@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030303191908.GA3609@mars.ravnborg.org>; from sam@ravnborg.org on Mon, Mar 03, 2003 at 08:19:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 08:19:08PM +0100, Sam Ravnborg wrote:
> On Mon, Mar 03, 2003 at 06:53:37PM +0000, Christoph Hellwig wrote:
> > Ah, okay :)  I newer use either menuconfig nor xconfig so I can't comment
> > on it's placements.  If people who actually do use if feel that it's placed
> > wrongly feel free to submit a patch to fix it.
> 
> The following patch moves it to the menu "Processor type & features"
> Right before HIMEM.

Looks fine to me.

