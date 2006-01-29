Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWA2XTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWA2XTf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 18:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWA2XTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 18:19:35 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:51357 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932072AbWA2XTe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 18:19:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ShOU5CT770hSfIcqkdMuiSWprTeHl1imlMKeAjfhTPCjkXiAY2EIQtA5ZdgMgLhLXroBj9qjBwZQLON3tWlRgpjipiEK298c43mYoKWsfAe5JJjAp0w+1BCeGdzGqmdQUY5n9LmA97+mt2FLldfqlqE6FvVRDnjTO8xmpGN7yzg=
Message-ID: <9a8748490601291519k623a518apee03c95da8d21b96@mail.gmail.com>
Date: Mon, 30 Jan 2006 00:19:33 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc1-mm4
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060129144533.128af741.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060129144533.128af741.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm4/
>
[...]
>
> - If you have a patch in -mm which you think should go into 2.6.16, it
>   doesn't hurt to remind me.  There's quite a lot here which will go into
>   2.6.16.
>
Well, the following 4 patches have been in -mm for a while, are fairly
trivial and I've not heard any complains about them, so I guess they
might as well move on and get into 2.6.16 :

   decrease-number-of-pointer-derefs-in-jsm_ttyc.patch
   docs-update-missing-files-and-descriptions-for-filesystems-00-index.patch
   reduce-nr-of-ptr-derefs-in-fs-jffs2-summaryc.patch
   sound-remove-unneeded-kmalloc-return-value-casts.patch


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
