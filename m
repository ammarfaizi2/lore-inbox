Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030398AbWGJORn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbWGJORn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 10:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030401AbWGJORn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 10:17:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:26736 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030398AbWGJORm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 10:17:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h/gUPDiPDpYw0MOCLuHUhKWIvpdi83SwF+6Y9ub/zC1IGKWrkzUWzwskCbUbTzUttRklfNzZiZlBfZSSCxk1IksTLTRtA9VLmPJ2YGMIm7U4X6otQlfqIOj8PjJxR2H+27VrHFnjPRcPUVDibI2scnvWYEGmKZEkWlpJTDQfLAo=
Message-ID: <9a8748490607100717p4d90a654v9386917e85a4de90@mail.gmail.com>
Date: Mon, 10 Jul 2006 16:17:41 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Subject: Re: [RFC][PATCH 1/9] -Wshadow: Add -Wshadow to toplevel Makefile
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1152540852.3373.67.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607101312.27738.jesper.juhl@gmail.com>
	 <1152540852.3373.67.camel@pmac.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/06, David Woodhouse <dwmw2@infradead.org> wrote:
> On Mon, 2006-07-10 at 13:12 +0200, Jesper Juhl wrote:
> > (please see the mail titled
> >  "[RFC][PATCH 0/9] -Wshadow: Making the kernel build clean with -Wshadow"
> >  for an explanation of why I'm doing this)
>
> I can't. You seem to have forgotten to send your sequence of emails as a
> _thread_.
>

Yeah I screwed up a bit :-(
0/9 is on LKML now though. If you want I can also forward you a copy.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
