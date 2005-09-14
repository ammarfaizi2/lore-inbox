Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbVINWxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbVINWxu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbVINWxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:53:50 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:63927 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030269AbVINWxt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:53:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K/6bjXPPbZ3BdmobLijvpP4f+tAowN3A1Y6zxL9eA4rbDIGvPM7YHi1ZxlM2bXE3Wj5HdsZAxqdBtoDEskWmxEluqLf3rYNRIyT0V9+dZ/LeALWFOFhsGSkVsEnaSLWsTue+13Xs4lNk2th4Njsjjx2pFWTRqLvY+1eT9pf7uNE=
Message-ID: <6bffcb0e05091415533d563c5a@mail.gmail.com>
Date: Thu, 15 Sep 2005 00:53:43 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Reply-To: michal.k.k.piotrowski@gmail.com
To: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Subject: Re: Automatic Configuration of a Kernel
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050914223836.53814.qmail@web51011.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050914223836.53814.qmail@web51011.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/09/05, Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com> wrote:
> Hi
> 
> I wrote this Framework for making a .config based on
> the System Hardwares. It would be a great help if some
> people would give me their opinion about it.
> 
> Regards

It's for new linux users? They should use distributions kernels.
It's for "power users"? They just do make menuconfig...
It's for kernel developers? They just do vi .config.

I'll try it later, but I'm a bit sceptical.

How about networking options? It can detect what protocols are needed?
Filesystems?

Regards,
Michal Piotrowski
