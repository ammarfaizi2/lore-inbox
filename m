Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424115AbWKQBMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424115AbWKQBMG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 20:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424722AbWKQBMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 20:12:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43434 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1424115AbWKQBMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 20:12:03 -0500
Date: Thu, 16 Nov 2006 17:11:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: linas@austin.ibm.com (Linas Vepstas)
Cc: Michael Ellerman <michael@ellerman.id.au>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@redhat.com>, "Ryan S. Arnold" <rsa@us.ibm.com>,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: HVCS char driver janitoring: fix compile warnings
Message-Id: <20061116171136.3eae31f9.akpm@osdl.org>
In-Reply-To: <20061117005540.GF23600@austin.ibm.com>
References: <20061115212619.GJ8395@austin.ibm.com>
	<1163635387.8805.7.camel@localhost.localdomain>
	<20061116203946.GA23600@austin.ibm.com>
	<1163716536.16815.5.camel@localhost.localdomain>
	<20061117005540.GF23600@austin.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2006 18:55:40 -0600
linas@austin.ibm.com (Linas Vepstas) wrote:

> On Fri, Nov 17, 2006 at 09:35:36AM +1100, Michael Ellerman wrote:
> > 
> > Thanks, new patches look good.
> 
> Any clue who I should send these to? I think akpm took the earlier
> one,

I grabbed the new ones.  (and gave them vaguely conventional changelogs)

> I'm not clear if that means it will slosh into Linus' tree 
> eventually.

It does, unless something bad happens to them along the way.  But you'd hear
about it if that occurs.
