Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261859AbSJQUG1>; Thu, 17 Oct 2002 16:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261863AbSJQUG1>; Thu, 17 Oct 2002 16:06:27 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:35335 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261859AbSJQUG0>; Thu, 17 Oct 2002 16:06:26 -0400
Date: Thu, 17 Oct 2002 21:12:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021017211223.A8095@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, linux-security-module@wirex.com
References: <20021017195015.A4747@infradead.org> <20021017185352.GA32537@kroah.com> <20021017195838.A5325@infradead.org> <20021017190723.GB32537@kroah.com> <20021017210402.A7741@infradead.org> <20021017201030.GA384@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021017201030.GA384@kroah.com>; from greg@kroah.com on Thu, Oct 17, 2002 at 01:10:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 01:10:31PM -0700, Greg KH wrote:
> > > How would they be done differently now?  Multiple different syscalls?
> > 
> > Yes.
> 
> Hm, in looking at the SELinux documentation, here's a list of the
> syscalls they need:
> 	http://www.nsa.gov/selinux/docs2.html
> 
> That's a lot of syscalls :)

I know.  but hiding them doesn't make them any better..

