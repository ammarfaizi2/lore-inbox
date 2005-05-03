Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVECES1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVECES1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 00:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVECESZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 00:18:25 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:46407 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261372AbVECESL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 00:18:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Nqxyrn5TUegxLcNZvxjMIBoSkEFCVqbxxkWIhHyH4CNfvQX6QwCHHF2CXyryLlbaAhGBP00tSFYBxy2oD3Ov2pjz/98zhdpWN4Ls/XxmzgZP6jnnRlNWz61iFeGrBwj1VVbgdNsm0Yw5hAL6GMAfdMiAV9mU/88mJs14uysU4QI=
Message-ID: <d4757e600505022118131ec083@mail.gmail.com>
Date: Tue, 3 May 2005 00:18:05 -0400
From: Joe <joecool1029@gmail.com>
Reply-To: Joe <joecool1029@gmail.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: Empty partition nodes not created (was device node issues with recent mm's and udev)
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
In-Reply-To: <20050502202620.04467bbd.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d4757e6005050219514ece0c0a@mail.gmail.com>
	 <20050503031421.GA528@kroah.com>
	 <20050502202620.04467bbd.rddunlap@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/05, Randy.Dunlap <rddunlap@osdl.org> wrote:
> Could this 2.6.11.8 -stable patch fix it?
> Subject: [04/07] partitions/msdos.c fix
> 
> Joe, can you test 2.6.11.8, please?
> 
> ---
> ~Randy
> 

Randy, Can't run vanilla at the moment on this setup, any way you can
get the patch seperate?  I also don't think that will fix it because
this is an empty, not a msdos partition.

Thanks,
Joe
