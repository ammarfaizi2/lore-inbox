Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbVKUL7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbVKUL7B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 06:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbVKUL7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 06:59:01 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:27225 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932269AbVKUL7B convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 06:59:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S10gktie/rc6ViUzuVFEOHn4U2PiDlqPfOlSy+ObS67Qz7TKbrfXhmGbleOiV0BjXhkrdjGAs/0mARTiaKAKaGiXeiMhB5QG7yr4ED5lh+JgmH4oeChw761uMHWPHdke+WUy6a5A1VG81PHvMJKucz7r1oVASadEsQyTHNUUr+s=
Message-ID: <35fb2e590511210358h2972c060we4195d3d9007146d@mail.gmail.com>
Date: Mon, 21 Nov 2005 11:59:00 +0000
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Cal Peake <cp@absolutedigital.net>
Subject: Re: floppy regression from "[PATCH] fix floppy.c to store correct ..."
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jcm@jonmasters.org, torvalds@osdl.org, viro@ftp.linux.org.uk,
       hch@lst.de
In-Reply-To: <Pine.LNX.4.61.0511202225480.20017@lancer.cnet.absolutedigital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0511160034320.988@lancer.cnet.absolutedigital.net>
	 <20051116005958.25adcd4a.akpm@osdl.org>
	 <20051119034456.GA10526@apogee.jonmasters.org>
	 <Pine.LNX.4.61.0511202225480.20017@lancer.cnet.absolutedigital.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/05, Cal Peake <cp@absolutedigital.net> wrote:

> This patch fixes it for me. If you cook up anything
> else I'll give it a go as well. Thanks Jon.

I think we'll end up going with that for the time being. I am itching
to break the rest of floppy.c but don't have a lot of time this week -
will followup with Andrew later.

Also, I'm going to resend those gendisk bits I was proposing earlier,
but without the offensive parts.

Jon.
