Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbVDOFYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVDOFYL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 01:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVDOFYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 01:24:11 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:38701 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261718AbVDOFYG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 01:24:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=P7fASUuRtFEptWVoCkhiYxcnQ3d6bfy/zIhcJmgDuHJSKUYUHIz06kA5LZX9OhlmaTsbQBQDQUr/zV4Qt1Nx6OXa5+B4ulZTIy6tA9uY1ckfe4PFgLHEwO7LushNDyfnG8WlBWJINE31DyU7FBn9qt6soTOZYDuJP6dYQllnV1o=
Message-ID: <17d79880504142224b4514f@mail.gmail.com>
Date: Fri, 15 Apr 2005 01:24:05 -0400
From: Allison <fireflyblue@gmail.com>
Reply-To: Allison <fireflyblue@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel module_list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right now , I am just learn. trying a test module that lists out all the modules

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
