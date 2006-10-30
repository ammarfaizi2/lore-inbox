Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWJ3McO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWJ3McO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 07:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWJ3McN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 07:32:13 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:4135 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932138AbWJ3McN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 07:32:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kwuf6YaO4qzE0Qg3kI9SnN1ycXt6EXyPGEeLhMec34HQUh0b/9P6DxX1e0/8o/aTn/gxXciM8oy5SnZtsP5iVTrUkoPKPrbH/qhxrJWAsSWLju4O7qbPfpJc5/QhP6AcypZkqZ/9rmcj9R1mVaGgNP8CTvyiRuo/PItZwz1suJE=
Message-ID: <9a8748490610300432m45e560f8gdaeb951877e2532e@mail.gmail.com>
Date: Mon, 30 Oct 2006 13:32:11 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Metathronius Galabant" <m.galabant@googlemail.com>
Subject: Re: user-space command "ipcs" seems broken on 2.6.18.1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1b270aae0610300414u4175fec6i30a1396dde260ca1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1b270aae0610300414u4175fec6i30a1396dde260ca1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/06, Metathronius Galabant <m.galabant@googlemail.com> wrote:
> Hi,
>
> the user-space command "ipcs" seems somewhat broken on my 2.6.18.1 as
> it doesn't output anything, uses 100% CPU and isn't kill'able.
> strace'ing it shows nothing/simply blocks.
>
> Distro is CentOS 4.4, Kernel 2.6.18.1 x86 SMP, gcc version 3.4.6
> 20060404 (Red Hat 3.4.6-3).
> Google didn't turn up anything. Any suggestions to track that down?
>
Can you identify the latest kernel where it works OK?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
