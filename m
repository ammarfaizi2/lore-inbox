Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVDNUtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVDNUtG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 16:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVDNUtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 16:49:05 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:10204 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261548AbVDNUsu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 16:48:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZEY1/jKxaPzVlPI1CkqmR5MxgRpgxmXVODthSe3977AxBjLjSHtReVakGEHGq3UPmB4fQyvTbJV45QIY+qnR3RA3D+Dkz3OwmKn1N208NKAYKF2BFScnT7MxMoS3qO1WoXABDwNcHCwGnO0FsFc/hXCUDdMKijxDJdLQq75TTNc=
Message-ID: <17d798805041413482f5a48c@mail.gmail.com>
Date: Thu, 14 Apr 2005 20:48:42 +0000
From: Allison <fireflyblue@gmail.com>
Reply-To: Allison <fireflyblue@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to simply print out the module names and code sizes.
I am just learning how to rtraverse these data structures.

Also, on what basis is the decision made whether to export a symbol or not ?

thanks,
Allison

Arjan van de Ven wrote:
> On Thu, 2005-04-14 at 19:53 +0000, Allison wrote:
> > 
> > I am trying to access the module list kernel data structure from a
> > kernel module. If I gather correctly, module_list is the symbol that
> > is the head pointer of this list.
> 
> can you explain what you want to do with this symbol ?
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
