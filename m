Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbVLNIh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbVLNIh3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 03:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbVLNIh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 03:37:29 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:25789 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932116AbVLNIh2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 03:37:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WaCyzDW7AJat3gAHWH9SZooTThK11j1NkFFBDsiJ6YQqBjDPHIdUcdRQIoLhXNDXuYJHGtbu7ikapM1bgevRp+0ORhh+sUCMKvh+tUY6B7VgWTh6fhJTMDjmUlZtv3kZXV5AhhUobENH1rEzlGwmMtyDKtqYfdTKHeVY0qUfTaw=
Message-ID: <9a8748490512140037s32386facq15256636164e6b8f@mail.gmail.com>
Date: Wed, 14 Dec 2005 09:37:27 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [PATCH] fix warning and missing failure handling for scsi_add_host in aic7xxx driver
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org,
       "Daniel M. Eischen" <deischen@iworks.interworks.org>,
       Doug Ledford <dledford@redhat.com>
In-Reply-To: <1134548429.3262.4.camel@mulgrave>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512140007.20046.jesper.juhl@gmail.com>
	 <1134534839.3133.2.camel@mulgrave>
	 <9a8748490512140002s8daf671h6db51bff1c06c834@mail.gmail.com>
	 <1134548429.3262.4.camel@mulgrave>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/05, James Bottomley <James.Bottomley@steeleye.com> wrote:
> On Wed, 2005-12-14 at 09:02 +0100, Jesper Juhl wrote:
> > I'll send a new patch later today when I get home from work.
>
> Actually, the aic79xx has the identical problem, if you want to fix that
> too ...
>
Sure, will do.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
