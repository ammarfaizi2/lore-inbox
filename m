Return-Path: <linux-kernel-owner+w=401wt.eu-S1030358AbXAEHOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbXAEHOp (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 02:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbXAEHOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 02:14:45 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:26962 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030358AbXAEHOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 02:14:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=A/b9YX4LZLUYn6CVm95uAwznpUvsVEf/jLe0j6B/ZOzMNzU3C6MnxYwbCZe0iglS8QARwu/K22ak+pWfcPYTLIS3lA7gfDlX3CSeYFl6IY/616Jt67Ii9l+W4qdSIH9Q59BKkajtWEtR4EuQBlhv06WcRGqscNnakXA/osyC51o=
Date: Fri, 5 Jan 2007 09:14:37 +0200
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3] TTY_IO: Remove unnecessary kmalloc casts
Message-ID: <20070105071437.GB13571@Ahmed>
Mail-Followup-To: "Robert P. J. Day" <rpjday@mindspring.com>,
	linux-kernel@vger.kernel.org
References: <20070105063600.GA13571@Ahmed> <Pine.LNX.4.64.0701050154020.21674@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701050154020.21674@localhost.localdomain>
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2007 at 01:56:09AM -0500, Robert P. J. Day wrote:
> On Fri, 5 Jan 2007, Ahmed S. Darwish wrote:
> 
> > Remove unnecessary kmalloc casts in drivers/char/tty_io.c
> 
> rather than remove these casts a file or two at a time, why not just
> do them all at once and submit a single patch?  there aren't that many
> of them:

OK, Thanks for the tip ..

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
