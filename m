Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262963AbVF3TKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbVF3TKy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 15:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262964AbVF3TKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 15:10:54 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:18719 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262963AbVF3TKw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 15:10:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EmfV8en2B9HmtPKfc++phbKUuGrpcKKiRaApiMVKPMl7+pooIdLuT6EJ2oyJ7jhep7QOb+EL/QxR/ZYDjpUFPbFqCOyIG6R914VnhM5WVNzN26hsxJEvSoPxG4cyDFkLmwd3M1FKL8Mn9rx8BsItJtO/gdiSHgtmg7eYQJK05OU=
Message-ID: <9a874849050630121031e6ecf3@mail.gmail.com>
Date: Thu, 30 Jun 2005 21:10:47 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: mkrufky@m1k.net
Subject: Re: [TRIVIAL 2.6.12 / 2.6.13 PATCH] v4l cx88 hue offset fix
Cc: Andrew Morton <akpm@osdl.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>, trivial@rustcorp.com.au,
       linux-kernel@vger.kernel.org
In-Reply-To: <42C41B0B.2080708@m1k.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42C35C65.8030900@m1k.net> <42C3F871.7060008@brturbo.com.br>
	 <42C41B0B.2080708@m1k.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/05, Michael Krufky <mkrufky@m1k.net> wrote:
> Mauro Carvalho Chehab wrote:
> 
> >Acked-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
> >
> >This small patch fixes top complaint about CX88 cards, which had a
> >different behavior than other V4L cards for hue setting.
> >
[...]
> 
> I would send this to Greg Kroah-Hartman / Chris Wright myself, but I
> don't know if that is proper protocol for doing this.

http://kerneltrap.org/mailarchive/1/message/33322/thread
See the "Procedure for submitting patches to the -stable tree" section
in particular.

(that document really should go into Documentation/ by the way)

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
