Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946505AbWKJL2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946505AbWKJL2d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 06:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424392AbWKJL2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 06:28:33 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:40465 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1424391AbWKJL2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 06:28:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fCHHwCqJ9m2c3E1871yH1gowI7R+A8pACjsqSoEDqqcmA18An3hQRej0gq3JVR9WdVJrpqqEIqFhyMdG7f+6TsBTMB3AlHvl4HNzV6ttAS2Zs2N5Ni2Tgk4lhpgUqMbRd2bWqR30f3AnVzDNOFWDtz9ToBHj7e+NkTjZh6uWZow=
Message-ID: <9a8748490611100328w75ccf2e8uc1121a80e68242d8@mail.gmail.com>
Date: Fri, 10 Nov 2006 12:28:30 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Ludovic Drolez" <ludovic.drolez@linbox.com>
Subject: Re: 2.6.18.2: cannot compile with gcc 3.0.4
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <45545C1B.4040204@linbox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45545C1B.4040204@linbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/06, Ludovic Drolez <ludovic.drolez@linbox.com> wrote:
> Hi !
>
> When I try to compile the latest kernel with 3.0.4, I get a parse error:
>

If you had bothered to read Documentation/Changes then you would have
seen that the current minimal required gcc version is 3.2 :

"
...
Current Minimal Requirements
============================

Upgrade to at *least* these software revisions before thinking you've
encountered a bug!  If you're unsure what version you're currently
running, the suggested command should tell you.

...

o  Gnu C                  3.2                     # gcc --version
...
"

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
