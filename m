Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275110AbRJYPqb>; Thu, 25 Oct 2001 11:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275098AbRJYPqU>; Thu, 25 Oct 2001 11:46:20 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:51085 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S275126AbRJYPqI>; Thu, 25 Oct 2001 11:46:08 -0400
Date: Thu, 25 Oct 2001 11:46:30 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Steve Lord <lord@sgi.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Frontgate Lab <mdiwan@wagweb.com>,
        linux-kernel@vger.kernel.org
Subject: Re: kernel compiler
Message-ID: <20011025114630.K25384@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <alan@lxorguk.ukuu.org.uk> <200110251527.f9PFRIx15728@jen.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200110251527.f9PFRIx15728@jen.americas.sgi.com>; from lord@sgi.com on Thu, Oct 25, 2001 at 10:27:18AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2001 at 10:27:18AM -0500, Steve Lord wrote:
> Just for information, none of the Redhat compilers (the 2.96 leg) build
> all of XFS correctly, see this bug for info:
> 
> http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=54571

Yeah, but it is a longstanding reload bug you can get bitten on other code
in 2.95.x, 3.0.x or 3.1 too, you just have to stress the compiler hard and
have bad luck.

	Jakub
