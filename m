Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030502AbVKCXJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030502AbVKCXJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030499AbVKCXJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:09:24 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:11993 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030502AbVKCXJX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:09:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pEuswujDyskeK/3jf4vFZWsmfEE4i2fC5okJ1l6h3D4p1hMbckHLnZbm8PlGU+9UKseQg6oqYD+dPw/SdW2viXEwF87pRCNcJS6nqj72Aa9EK6e18JQ1l+1kpfhn6jWkmN3fq0zx7HoDlSnGpjnDwP+5q9J2T53YdhD2VIhDh8k=
Message-ID: <9a8748490511031509p16623571xf4c77df4881f4b18@mail.gmail.com>
Date: Fri, 4 Nov 2005 00:09:22 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Subject: Re: 2.6.14-git6.{gz,bz2} patches on kernel.org are empty
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5a4c581d0511030525y8d587f9x880281abaffbf50c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a4c581d0511030525y8d587f9x880281abaffbf50c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/05, Alessandro Suardi <alessandro.suardi@gmail.com> wrote:
> .log is present, .gz and .bz2 patches are empty.
>

I just downloaded the .gz and -bz2 files of the 2.6.14-git6 patches
from kernel.org and they are far from empty :

$ ls -l patch-2.6.14-git6.*
-rw-r--r--  1 juhl users 2896172 2005-11-04 00:10 patch-2.6.14-git6.bz2
-rw-r--r--  1 juhl users 3552327 2005-11-04 00:10 patch-2.6.14-git6.gz

Also, extracting the files yields nice working patches.

You must have a broken download or similar problem. The patches are fine.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
