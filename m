Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbTLWX6b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 18:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbTLWX6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 18:58:31 -0500
Received: from crisium.vnl.com ([194.46.8.33]:13573 "EHLO crisium.vnl.com")
	by vger.kernel.org with ESMTP id S262878AbTLWX6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 18:58:30 -0500
Date: Tue, 23 Dec 2003 23:58:27 +0000
From: Dale Amon <amon@vnl.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
Subject: Re: Question on LFS in Redhat
Message-ID: <20031223235827.GK9089@vnl.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>,
	Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
References: <20031223151042.GE9089@vnl.com> <1072193917.5262.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072193917.5262.1.camel@laptop.fenrus.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 04:38:38PM +0100, Arjan van de Ven wrote:
> On Tue, 2003-12-23 at 16:10, Dale Amon wrote:
> > If there are any Redhat folk around... could you tell
> > me if you've included the LFS patches in your:
> > 
> > 	2.4.16-9smp
> 
> Red Hat never released a 2.4.16 kernel for production use.

Hmmm, that's what is showing and the Raidzone guy here in
the UK told me they are stock... 

> However we also never released a 2.4 kernel with the large BLOCK patch.
> All 2.4 kernels we shipped can do files > 2 Gb of course.

But you wouldn't be able to handle file systems larger
than 2TB then I presume?

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------
