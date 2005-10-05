Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbVJERsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbVJERsG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 13:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbVJERsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 13:48:06 -0400
Received: from web35905.mail.mud.yahoo.com ([66.163.179.189]:22141 "HELO
	web35905.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030297AbVJERsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 13:48:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=K5FF1gdvh834quelKQOq9PxHVAVwAkhFLCp61mKpKONGjFjF6mvw4t4tDt8KJX0wuiediZM5MwywYP7KovzzTXrfogJOB9zPcRnvFNw+tKZetCzlRSLY81GzHwpT5zpVARIacaVuIyoz21COXv5sJ5SfThb4nFbrHYqS4AA3nxQ=  ;
Message-ID: <20051005174803.70134.qmail@web35905.mail.mud.yahoo.com>
Date: Wed, 5 Oct 2005 10:48:03 -0700 (PDT)
From: umesh chandak <chandak_pict@yahoo.com>
Subject: Re: Kernel Panic Error in 2.6.10 !!!!
To: Badari Pulavarty <pbadari@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1128534181.4754.68.camel@dyn9047017102.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
thanks for reply . 
 
But as i am using  gbdb patches on my test machine .i
don't need initrd ,i am sure about it .and I can enter
in my other kernel options . So I have my ide
configured ,is this correct ?  
--- Badari Pulavarty <pbadari@gmail.com> wrote:

> On Wed, 2005-10-05 at 10:35 -0700, umesh chandak
> wrote:
> > hi,
> >          I have compiled the kernel 2.6.10 with
> KGDB
> > patches on FC3 .My KGDB connetion are made correct
> .
> > I have copied bzImage and System.map on test
> machine .
> > but when i press C for continuig no devlopment m/c
> > after  connection are made.It gives me kernel
> panic
> > error like this 
> > 
> > VFS: Cannot open root device "hda6" or
> > unknown-block(3,6)
> > Please append a correct "root=" boot option Kernel
> > panic - not syncing: VFS: Unable to mount root fs
> on
> > unknown-block(3,6)
> 
> You might need initrd or make sure "ide" is
> configured
> in your kernel.
> 
> Thanks,
> Badari
> 
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
