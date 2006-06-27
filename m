Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422727AbWF0X1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422727AbWF0X1A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 19:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422729AbWF0X1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 19:27:00 -0400
Received: from mail-03.jhb.wbs.co.za ([196.2.97.2]:8590 "EHLO
	mail-03.jhb.wbs.co.za") by vger.kernel.org with ESMTP
	id S1422727AbWF0X07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 19:26:59 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAARaoUSKLQcOKg
From: Bongani Hlope <bhlope@mweb.co.za>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Subject: Re: keyboard repeat-rate borked with recent linux-2.6 git tree...
Date: Wed, 28 Jun 2006 01:28:02 +0200
User-Agent: KMail/1.9.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
References: <20060627210319.GA16504@andrew-vasquezs-powerbook-g4-15.local> <20060627210757.GB16504@andrew-vasquezs-powerbook-g4-15.local>
In-Reply-To: <20060627210757.GB16504@andrew-vasquezs-powerbook-g4-15.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606280128.02945.bhlope@mweb.co.za>
X-Original-Subject: Re: keyboard repeat-rate borked with recent linux-2.6 git tree...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think you'll have better luck with the gmail account ;)

On Tuesday 27 June 2006 23:07, Andrew Vasquez wrote:
> ok, the mail.ru address bounced... retrying ameritech.net.
>
> On Tue, 27 Jun 2006, Andrew Vasquez wrote:
> > Date: Tue, 27 Jun 2006 14:03:19 -0700
> > From: Andrew Vasquez <andrew.vasquez@qlogic.com>
> > To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> > Cc: Dmitry Torokhov <dtor@mail.ru>
> > Subject: keyboard repeat-rate borked with recent linux-2.6 git tree...
> > Organization: QLogic Corporation
> > User-Agent: Mutt/1.5.11
> >
> > Key repeats while depressing any key are broken due to the following
> > commits:
> >
> > Input: atkbd - fix HANGEUL/HANJA keys
> > 0ae051a19092d36112b5ba60ff8b5df7a5d5d23b
> >
> > Input: fix misspelling of Hangeul key
> > b9ab58dd8e771d30df110c56e785db1ae5e073df
> >
> > reverting 0ae051a19 fixes the lack-of-key repeats...
> >
> > --
> > av
> > realizing how annoying it is to have to hit 'j' 10 times to move ten
> > lines...
