Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbVIEASW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbVIEASW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 20:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbVIEASW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 20:18:22 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:26193 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932237AbVIEASW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 20:18:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=umZwGi2Lj4hKX3C3G1RL/9sH0kNNEJMBwUDFXFLzBrLedBYzjJP7d6s8QXEraL2aNsMG+tuwUXNmvfM1Q31KFDDvHOABj+c3IYVZSBSGZ3F0gND4AZ8REvsw7aQkbVlHPPJajlyy7ZJbQFm9CqwpRlY9xhvdL0oblbBXMeXhmB8=
Message-ID: <9a87484905090417183c26a5a5@mail.gmail.com>
Date: Mon, 5 Sep 2005 02:18:21 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: 2.6.11.11 and rsync oops (SATA related?)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <dfg2i0$p2e$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <dfg2i0$p2e$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/05, Kalin KOZHUHAROV <kalin@thinrope.net> wrote:
> Hi, there.
> Long time no posting - didn't have kernel problems for long time :-)
> 
> That is why I am still running 2.6.11.11 (2.6.12 elsewhere). Will move
> to 2.6.13 soon.
> 
> Yesterday just bought a new SATAII drive (Seagate Barracuda 7200.8
> ST3300831AS) and while trying to rsync some data from the old drives the
> rsync process died with segfault. My SiI3112 controller is not SATAII,
> but it should work in SATA mode, have another drive for year+. Looking
> at the dmesg I saw 3 oopses (see the shortened .dmesg file). Run the
> ksymoops and got some output (see .ksymoops.bz2).
> 

It seems you forgot to include the data.  Nothing inline in the email,
nor any attachments.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
