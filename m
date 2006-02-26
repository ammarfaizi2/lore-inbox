Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWBZVtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWBZVtD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 16:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWBZVtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 16:49:02 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:42809 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750823AbWBZVtA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 16:49:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m4nNt4NaHq+J0qrcmAB5dFQYNzsqk02UGiGWkOfvTpZ8BMFmX4AjBncidsQtmL7TWNF6yMiUwVcYRpi6GGtFlreqi0UJ1m/0YZeWVuzWydffcjE1lz417J21ggD6Ncevd9rJD3T5414EWYwdP41hic2NMQTCu0MUdamSqhzs9hE=
Message-ID: <9a8748490602261349v381933b9xeb2ddeedac053910@mail.gmail.com>
Date: Sun, 26 Feb 2006 22:49:00 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: Nix <nix@esperi.org.uk>
Subject: Re: Building 100 kernels; we suck at dependencies and drown in warnings
Cc: "Lee Revell" <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
In-Reply-To: <87wtfh3i9z.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602261721.17373.jesper.juhl@gmail.com>
	 <1140986578.24141.141.camel@mindpipe> <87wtfh3i9z.fsf@hades.wkstn.nix>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/06, Nix <nix@esperi.org.uk> wrote:
> (i.e., there's a reason that warning uses the word *might*.)
>
The compiler says "might be used uninitialized" when it cannot
determine if a variable will be initialized before first use or not.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
