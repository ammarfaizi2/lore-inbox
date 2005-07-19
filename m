Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbVGSKNC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVGSKNC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 06:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbVGSKNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 06:13:02 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:23747 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261892AbVGSKMe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 06:12:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gbaNVxLRSb4vqUaAuIT2YAjJBwxya62VhFjHr7v+PSbaxplABOn9KUAnen2Vv7RgE9e1Py8pnYVKLrw/uAkuO3mP+6LL5Sqh9RbyOz2Hnn0rJurPObGj7UtX+PnxAlZ95DlcqeU6NkxP+ZwYxjwTeFlqZrEnK2jTVQmS+H1ysNI=
Message-ID: <4d8e3fd3050719031258aee8e6@mail.gmail.com>
Date: Tue, 19 Jul 2005 12:12:33 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Mark Gross <mgross@linux.intel.com>
Subject: Re: Why is 2.6.12.2 less stable on my laptop than 2.6.10?
Cc: Rik van Riel <riel@redhat.com>, Dave Jones <davej@redhat.com>,
       Jesper Juhl <jesper.juhl@gmail.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200507181414.02262.mgross@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507140912.22532.mgross@linux.intel.com.suse.lists.linux.kernel>
	 <200507151447.46318.mgross@linux.intel.com>
	 <Pine.LNX.4.61.0507151914300.25957@chimarrao.boston.redhat.com>
	 <200507181414.02262.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/7/18, Mark Gross <mgross@linux.intel.com>:
> On Friday 15 July 2005 16:14, Rik van Riel wrote:
> > On Fri, 15 Jul 2005, Mark Gross wrote:
> > > What would be wrong in expecting the folks making the driver changes
> > > have some story on how they are validating there changes don't break
> > > existing working hardware?  I could probly be accomplished in open
> > > source with subsystem testing volenteers.
> >
> > Are you volunteering ?
> 
> I am not volunteering.  That last sentence was meant to say "It could
> probubly..."
> 
> I'm just poking at a process change that would include a more formal
> validation / testing phase as part of getting change into the stable tree.  I
> don't have any silver bullets.

I totaly agree with you, but the real problem is *how* to do that.
Do you have any suggestion ?

-- 
Paolo
