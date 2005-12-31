Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbVLaLIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbVLaLIx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 06:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVLaLIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 06:08:53 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:5931 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751078AbVLaLIx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 06:08:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IlPpnkSEXe1LZYXhBuoZqDDlTwYoZBnlhLZ3CAQBEYHTx97eovJgefC4Rikiv7gDKTdYk5EPDXoMM+QsjlhtbegVGZBQ+pAQCj7vDJWDQE+dJIxdEsQf8Vo5sTt3H2Z+YwttJTeYxt67XPtU0f3mmheMFq+hHcIokTSSyB/42b4=
Message-ID: <9a8748490512310308g1f529495ic7eab4bd3efec9e4@mail.gmail.com>
Date: Sat, 31 Dec 2005 12:08:52 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Mark v Wolher <trilight@ns666.com>
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Lee Revell <rlrevell@joe-job.com>,
       Folkert van Heusden <folkert@vanheusden.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43B65DEE.906@ns666.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43B53EAB.3070800@ns666.com>
	 <200512310027.47757.s0348365@sms.ed.ac.uk>
	 <43B5D3ED.3080504@ns666.com>
	 <200512310051.03603.s0348365@sms.ed.ac.uk>
	 <43B5D6D0.9050601@ns666.com> <43B65DEE.906@ns666.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/31/05, Mark v Wolher <trilight@ns666.com> wrote:
>
> g'morning !
>
> the memtest86 went 40 times over the memory, no errors detected.
>
Give memtest86+ a spin (http://www.memtest.org/) as well. memtest86 is
good, but I've found in the past that memtest86+ sometimes finds
errors that memtest86 does not, so giving both a sin fo an extended
period of time is usually a good idea.
Also, make sure you enable all the tests of both tools.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
