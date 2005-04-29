Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbVD2AdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbVD2AdK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 20:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbVD2AdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 20:33:10 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:60744 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262355AbVD2AdF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 20:33:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A1gOvi47DguXd/LNhwuOg9qcUjqEWh6xKc6VkUTg0NqGlprfQFyJE9dD0ucfHbd0iN/eqCsH7S2qfdBffarXxCBFp5P3cmna4dRpFs6v/GfzBCnpjnLmmFrfxecr8rHmtNF7214hlrtEmKJjv7k6Ef2qbPD9AC1Cy98YJ3RzRLw=
Message-ID: <58cb370e050428173360ebdf05@mail.gmail.com>
Date: Fri, 29 Apr 2005 02:33:04 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Question] Does the kernel ignore errors writng to disk?
Cc: mike.miller@hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, brace@hp.com
In-Reply-To: <1114732207.24687.263.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050427184022.GA16129@beardog.cca.cpqcorp.net>
	 <1114700283.24687.193.camel@localhost.localdomain>
	 <58cb370e050428162221be7338@mail.gmail.com>
	 <1114732207.24687.263.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > We agreed on this but it is you to do coding, if you want it,
> > not me (and there was never any patch from you).
> 
> I gave up sending you patches because they never got applied and all I
> got was "change this" or send a security fix and get told its got wrong

First to make it clear you never ever sent any patch 
for this _particular_ issue.

Oh and you've never changed "this" or even explained why is so
so no wonder why _some_ of your patches don't get applied.

> white spacing for your personal religion.

Sure I complain about your exotic whitespace and coding
style but I _never_ reject patches because of this.

> The bug is still there, and the users still need to know its dangerous.
> Perhaps that way someone will fix it.

Patches as usual are welcomed.
