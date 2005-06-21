Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbVFUPeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVFUPeK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 11:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbVFUP3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 11:29:32 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:14748 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262126AbVFUP1C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 11:27:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LcGj6IUfW5JnzgYtg+dfED2ZJYV1KiKGaXEa4aOYcacv0STk/udgXPvv1HNgoxLmEzGVyRWwSzxmk054HMvEs3+qB+8oz9UxiM/5cUSXgU4zC2ejClJsgtYfKs/8ayJrrPJafnb5IBgDuYty62GUdd5Xf9byHpJ9+ZpnU5Kgrz4=
Message-ID: <3aa654a405062108266a1d2df8@mail.gmail.com>
Date: Tue, 21 Jun 2005 08:26:57 -0700
From: Avuton Olrich <avuton@gmail.com>
Reply-To: Avuton Olrich <avuton@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: -mm -> 2.6.13 merge status (fuse)
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050620235458.5b437274.akpm@osdl.org>
	 <E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/05, Miklos Szeredi <miklos@szeredi.hu> wrote:
> I won't shed many tears if you drop fuse-nfs-export.patch.  It would
> at least give the userspace solution some boost.
> 
> However the patch is pretty small, and despite it's flaws, I know it's
> used by a number of people.

Why not leave it up to the user as an option, for the time being at
least. Does this somehow break things?

thanks,
avuton

-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
