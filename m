Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbVIOJ5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbVIOJ5A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 05:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbVIOJ5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 05:57:00 -0400
Received: from web51005.mail.yahoo.com ([206.190.38.136]:22106 "HELO
	web51005.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932430AbVIOJ47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 05:56:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=K+dHOL8UNlCkCBnigt3JvIE/CDKI8Zb9KrVkr5nGOIi36QZYP2SCzVJgQDCwAqm+WuxuAYBZu7Tq2ddNb/ZuHVlwdMzGPTPFU0WARxRHfbhSvNtCeV52Wmw91xCNqKMDMJEOtKN0x0yvYljXBPE1LiX1zuZGFL6/wfpHIxQVcMc=  ;
Message-ID: <20050915095658.68775.qmail@web51005.mail.yahoo.com>
Date: Thu, 15 Sep 2005 02:56:58 -0700 (PDT)
From: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Subject: Re: Automatic Configuration of a Kernel
To: michal.k.k.piotrowski@gmail.com
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <6bffcb0e05091415533d563c5a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Michal Piotrowski
<michal.k.k.piotrowski@gmail.com> wrote:

> Hi,
> 
> On 15/09/05, Ahmad Reza Cheraghi
> <a_r_cheraghi@yahoo.com> wrote:
> > Hi
> > 
> > I wrote this Framework for making a .config based
> on
> > the System Hardwares. It would be a great help if
> some
> > people would give me their opinion about it.
> > 
> > Regards
> 
> It's for new linux users? They should use
> distributions kernels.
> It's for "power users"? They just do make
> menuconfig...
> It's for kernel developers? They just do vi .config.
> 
> I'll try it later, but I'm a bit sceptical.
> 
> How about networking options? It can detect what
> protocols are needed?
> Filesystems?

The Network option or the Filesystes are choosen as a
Standard. So it will be there without checking if they
needed or not. Because I think Protocols like TCP-IP
or Filesystems like NTFS or expt2 has to be installed
on the now days Systems. But if they are any
suggestion or ideas of detecting those thing. No
problem just send me rule that does that and I will
updated easily on the Framework.Thats the benefit of
this Framework.;-)

> Regards,
> Michal Piotrowski
> 



		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
