Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932593AbVHJXN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbVHJXN1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 19:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbVHJXN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 19:13:27 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:6064 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932593AbVHJXN1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 19:13:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CuU/r278IwaxmGbvj2E6iera4ZdzVCJebRYi3rl3xkKUr+hrOJ4TeZYgC4FsZX+5SFGmz6f7HENd1blS8v+M77eeePPM3PmqZWQpjLp04E0o34Ke278i1pciA1S1z6bzqnjRee+RN9IFXN6Sv/hK+JXAATCX7CknzM6Q2572VIU=
Message-ID: <9a87484905081016134a55f7aa@mail.gmail.com>
Date: Thu, 11 Aug 2005 01:13:26 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "thomas.mey3r@arcor.de" <thomas.mey3r@arcor.de>
Subject: Re: 2.6.13-rc5 -> 2.6.13-rc6: ACPI patches seems break the kernel
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8017349.1123706059823.JavaMail.ngmail@webmail-08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <8017349.1123706059823.JavaMail.ngmail@webmail-08.arcor-online.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/05, thomas.mey3r@arcor.de <thomas.mey3r@arcor.de> wrote:
> Hello.
> My machine (i386, acer 1350) stops to work with 2.6.13-rc6. it works with "acpi=off". the abend seems to be a total deadlock. no system request keys works. no oops with log level 9.
> could someone please have a look at this?
> 

Perhaps if you provided a little more detail it would be easier for
someone to figure out what's wrong.

Your kernel config, your /proc/cpuinfo contents, and various other
bits of info listed in the REPORTING-BUGS file in the kernel source
dir, would probably be valuable to anyone wanting to investigate this
(not me though, I don't know anything about this area).


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
