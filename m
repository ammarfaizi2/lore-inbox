Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVCDBvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVCDBvd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 20:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbVCDBsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 20:48:31 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:3399 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262803AbVCDBox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 20:44:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=hHpMt3xgGuCT86WSMbObNgKhe0wO5ZfGUO4gNFnzxVbw/2TS4RwcvQsfXg8NtgT/NozkVgCUV4BQj5yP4p6y+ZBqiphMPxAQ2aRD7tgxvGwyVRMhF0zX92eDPEXpNAtQWNhPzaEtBoszqRMu9xgioDWb9Tozyxv60RCeTbgVyS0=
Message-ID: <5ca13e8305030317444bc5d254@mail.gmail.com>
Date: Fri, 4 Mar 2005 09:44:49 +0800
From: Zhonghua Dai <zhonghuadai@gmail.com>
Reply-To: Zhonghua Dai <zhonghuadai@gmail.com>
To: Ganesh Venkatesan <ganesh.venkatesan@gmail.com>
Subject: Re: trouble with Dell dimension 3000 network adapter
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5fc59ff30503020519250dc663@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <5ca13e830503020247676df272@mail.gmail.com>
	 <5fc59ff30503020519250dc663@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks Ganesh & Brice! Now it works!

i use the driver specified by ganesh at sourceforge. 

thanks.


On Wed, 2 Mar 2005 05:19:02 -0800, Ganesh Venkatesan
<ganesh.venkatesan@gmail.com> wrote:
> Did you try e100?  What kernel are you using? You could download the
> latest e100 from http://sourceforge.net/projects/e1000/.  The latest
> version 3.3.6.
> 
> ganesh.
> 
> 
> On Wed, 2 Mar 2005 18:47:56 +0800, Zhonghua Dai <zhonghuadai@gmail.com> wrote:
> > hi,
> >
> > I've installed the debian(woody) on my Dell dimension 3000 computer.
> > But I can't make the network adapter work, it's type is intel pro/100
> > VE network desktop adapter. I've tired such modules as eepro100,
> > eexpress, but it doesn't work.
> >
> > Any suggestion or information are welcomed?
> >
> > Thanks in advance.
> >
> > scar
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
