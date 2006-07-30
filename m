Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWG3Nxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWG3Nxi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 09:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWG3Nxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 09:53:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:34288 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932317AbWG3Nxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 09:53:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D6+gyEo8an8vgNAQzcPD/9SCwHv59uVQb3LbwNF9Ff03ekLsI1Ytgw/ERhyJo+ixmtSR30Bfyy9kbxKil/47XLT+/cefB2d//5F+63XfJ9rt7Qwagz5X2W3rtSnOGLonBmh+bKpmYA6UTIiK3CLBrrVENjzd3fj2hxgdBs4J9is=
Message-ID: <9a8748490607300653o7388a413ie8b181eb1416dae0@mail.gmail.com>
Date: Sun, 30 Jul 2006 15:53:36 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Larry Finger" <Larry.Finger@lwfinger.net>
Subject: Re: V2.6.18-rc2-latest git compilation fails on i386
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44CCB21C.1050206@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44CC18B2.4040309@lwfinger.net>
	 <9a8748490607292127ncea6bcep89f9841a09411b3@mail.gmail.com>
	 <44CCB21C.1050206@lwfinger.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/06, Larry Finger <Larry.Finger@lwfinger.net> wrote:
> Jesper Juhl wrote:
> > On 30/07/06, Larry Finger <Larry.Finger@lwfinger.net> wrote:
> >> When compiling the latest i386 kernel from Linus's tree with
> >> CONFIG_STACK_UNWIND
> >> defined, the following compilation error occurs:
> >>
> > I reported that problem yesterday and Alexey Dobriyan provided a fix :
> > http://lkml.org/lkml/2006/7/29/85
> >
>
> I don't subscribe to LKML and I missed your report of this problem in the summary.
> Sorry for the noise.
>
No worries. Better to have an issue reported twice than not have it
reported at all :-)


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
