Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVGXTXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVGXTXa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 15:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbVGXTXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 15:23:30 -0400
Received: from [202.136.32.45] ([202.136.32.45]:62145 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261480AbVGXTX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 15:23:29 -0400
From: Grant Coady <lkml@dodo.com.au>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3 test: finding compile errors with make randconfig
Date: Mon, 25 Jul 2005 05:23:09 +1000
Organization: www.scatter.mine.nu
Reply-To: lkml@dodo.com.au
Message-ID: <2vn7e1lfujeei07rocnr1sbavpbtpbcm6a@4ax.com>
References: <f8b6e1h2t4tlto7ia8gs8aanpib68mhit6@4ax.com> <9a8748490507240601ec7a940@mail.gmail.com>
In-Reply-To: <9a8748490507240601ec7a940@mail.gmail.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jul 2005 15:01:22 +0200, Jesper Juhl <jesper.juhl@gmail.com> wrote:
>> context.  Deliberately simplistic for traceability at the moment, truncated
>> error length for this post.
>> 
>If you could put the data online somewhere I'd be interrested in
>taking a look at it.
7.4MB raw data --> low info content.  Needs garbage removal.  Good 
test case for gzip vs bzip2 --> 1.4MB vs 481kB, 

  ftp://ftp.scatter.mine.nu/develop/first_run.tar.bz2 (481kB)

If you mean online info-sys, I don't have bandwidth for that :(

>An easy way to look at the build log and grab the matching .config for
>any given run would be great.

Revisit the data extraction and build an errorlog line_index...  
Will let you know.  

Grant.

