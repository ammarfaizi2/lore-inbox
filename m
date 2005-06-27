Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbVF0WnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVF0WnU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 18:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVF0WnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 18:43:19 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:51788 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262057AbVF0Wmo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 18:42:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iUqpOKZ5ek0HhjLiyK9nAIqbPcuhl83RrcLooBfRf3ICaEttfBVoxSt//8/+lxT8rHt2U5OmOidnzDPuDD7XNy3wmFlTHiInz/woB4C8VSBj4jQc7Hk9cjJob1VE/d1T1vkO4+B2tYcwa4QcbyNAKrEM6izCWTFqDYnBrT0x9AM=
Message-ID: <fc67f8b705062715424a8f9759@mail.gmail.com>
Date: Mon, 27 Jun 2005 15:42:40 -0700
From: Ritesh Kumar <digitalove@gmail.com>
Reply-To: ritesh@cs.unc.edu
To: Pekka Enberg <penberg@gmail.com>
Subject: Re: Documentation about the Virtual File-System
Cc: =?ISO-8859-1?Q?Guillermo_L=F3pez_Alejos?= <glalejos@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <84144f0205062710582ca366c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <4fec73ca05062710082e273097@mail.gmail.com>
	 <84144f0205062710582ca366c0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/05, Pekka Enberg <penberg@gmail.com> wrote:
> Hi,
> 
> On 6/27/05, Guillermo López Alejos <glalejos@gmail.com> wrote:
> > Is there any "Building a File system HOWTO"?
> 
> I am not aware of such document but take a look at fs/ramfs/inode.c.
> It is a simple memory-based filesystem and sort of a tutorial to the
> VFS.
> 
>                                Pekka
> -

Did you try http://lxr.linux.no/source/Documentation/filesystems/vfs.txt

BTW, on a similar note can somebody recommend some simple sample code
on block IO?

Ritesh

> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
http://www.cs.unc.edu/~ritesh/
