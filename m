Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262180AbSJQUjc>; Thu, 17 Oct 2002 16:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262181AbSJQUjc>; Thu, 17 Oct 2002 16:39:32 -0400
Received: from tsv.sws.net.au ([203.36.46.2]:52233 "EHLO tsv.sws.net.au")
	by vger.kernel.org with ESMTP id <S262180AbSJQUjb>;
	Thu, 17 Oct 2002 16:39:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Date: Thu, 17 Oct 2002 22:45:20 +0200
User-Agent: KMail/1.4.3
References: <20021017195015.A4747@infradead.org> <20021017210402.A7741@infradead.org> <20021017201030.GA384@kroah.com>
In-Reply-To: <20021017201030.GA384@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210172245.20238.russell@coker.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2002 22:10, Greg KH wrote:
> Hm, in looking at the SELinux documentation, here's a list of the
> syscalls they need:
> 	http://www.nsa.gov/selinux/docs2.html
>
> That's a lot of syscalls :)

That documentation only includes references to the system calls that have man 
pages.  From a quick review ichsid() is missing so there's at least 1 more 
system call than is listed there.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

