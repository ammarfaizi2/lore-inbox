Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbUBXT55 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 14:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUBXT55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 14:57:57 -0500
Received: from mail.kroah.org ([65.200.24.183]:61144 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262421AbUBXT5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 14:57:55 -0500
Date: Tue, 24 Feb 2004 11:57:45 -0800
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>,
       "Woodruff, Robert J" <woody@co.intel.com>, linux-kernel@vger.kernel.org,
       "Hefty, Sean" <sean.hefty@intel.com>,
       "Coffman, Jerrie L" <jerrie.l.coffman@intel.com>,
       "Davis, Arlin R" <arlin.r.davis@intel.com>,
       marcelo.tosatti@cyclades.com, torvalds@osdl.org
Subject: Re: PATCH - InfiniBand Access Layer (IBAL)
Message-ID: <20040224195745.GA777@kroah.com>
References: <F595A0622682C44DBBE0BBA91E56A5ED1C36C7@orsmsx410.jf.intel.com> <20040224194430.GB639@kroah.com> <20040224195018.A27219@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040224195018.A27219@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 07:50:18PM +0000, Christoph Hellwig wrote:
> On Tue, Feb 24, 2004 at 11:44:30AM -0800, Greg KH wrote:
> > Please make those changes and then post the patch here (not just a link,
> > if it's too big, split it up into the logical pieces to fit.)  We can go
> > from there.
> 
> I don't understand why anyone is wasting time on this.  Without available
> hardware drivers this huge midlayer is completely useless.

You mean this whole huge chunk of code doesn't have any hardware
drivers?  What good is it then?

greg k-h
