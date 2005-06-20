Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVFTEJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVFTEJz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 00:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVFTEJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 00:09:55 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:50727 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261417AbVFTEJx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 00:09:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jsud1Ijnv7hgY7FE6KCv949JuwhuSig7hmpz8u4JZI+Uf/ZUGeCx/Zlpea8iINQs9JrJlutdHZGDbLf7/R76am7WN1kgBVUfOQQGALtpYy8zhJ/08dc+Imp3CXg6Moa1MqVHH6zBtWuIBvOMj7brxv8t+ulFIDu2ki+LI1odzpc=
Message-ID: <d73ab4d00506192109a824926@mail.gmail.com>
Date: Mon, 20 Jun 2005 12:09:52 +0800
From: guorke <gourke@gmail.com>
Reply-To: guorke <gourke@gmail.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Hi,make question
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <C2515872-AB06-4710-9F90-E8E4AEC1C6F0@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d73ab4d005061918441ae4a81f@mail.gmail.com>
	 <C2515872-AB06-4710-9F90-E8E4AEC1C6F0@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,I got it.
It beacuse  compiler segfaulted.


On 6/20/05, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> On Jun 19, 2005, at 21:44:30, guorke wrote:
> > hi,when complie 2.6.12,i meet the followning message,how to fix it?
> 
> RTFM (Read the f***ing message):
>   When you get an error message, it's usually best to do as it says.
> 
> > ipc/shm.c: In function `shm_inc':
> > ipc/shm.c:99: internal error: Segmentation fault
> > Please submit a full bug report,
> > with preprocessed source if appropriate.
> > See <URL:http://bugzilla.redhat.com/bugzilla/> for instructions.
> > make[1]: *** [ipc/shm.o] Error 1
> > make: *** [ipc] Error 2
> 
> Please note where it says: "See <URL> for instructions".  That usually
> means that you should visit the URL and read the instructions contained
> therein.
> 
> Cheers,
> Kyle Moffett
> 
> --
> There are two ways of constructing a software design. One way is to
> make it so simple that there are obviously no deficiencies. And the
> other way is to make it so complicated that there are no obvious
> deficiencies.
>  -- C.A.R. Hoare
> 
>
