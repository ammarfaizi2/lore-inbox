Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbUL2U4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbUL2U4q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 15:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbUL2U4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 15:56:46 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:20007 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261405AbUL2U4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 15:56:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=PCiPTAy8M8wd1CBvkXM3VXMNlko9I6M+BkaW9PzEYQ4py+jKHYEzV0/QEn6G5mZaEiNN0lBp3dXCgRAsvB1nGv+z7cncs5D5uBMZWnoWOZ1LezU6KV1f8SvcnVMDTnYwFwzV+gudKczDbjSHFYyNzd2RSP9GFMkq4HZVszyRECI=
Message-ID: <5304685704122912566e2b783e@mail.gmail.com>
Date: Wed, 29 Dec 2004 13:56:43 -0700
From: Jesse Allen <the3dfxdude@gmail.com>
Reply-To: Jesse Allen <the3dfxdude@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: ptrace single-stepping change breaks Wine
Cc: Mike Hearn <mh@codeweavers.com>, Thomas Sailer <sailer@scs.ch>,
       Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       wine-devel <wine-devel@winehq.com>
In-Reply-To: <53046857041229114077eb4d1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
	 <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org>
	 <20041120214915.GA6100@tesore.ph.cox.net>
	 <41A251A6.2030205@wanadoo.fr>
	 <Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>
	 <1101161953.13273.7.camel@littlegreen>
	 <1104286459.7640.54.camel@gamecube.scs.ch>
	 <1104332559.3393.16.camel@littlegreen>
	 <Pine.LNX.4.58.0412291047120.2353@ppc970.osdl.org>
	 <53046857041229114077eb4d1d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2004 12:40:53 -0700, Jesse Allen <the3dfxdude@gmail.com> wrote:
> For the wine people, I will try to upload the seh debug channel logs
> as soon as possible.
> 

I have a page with the latest logs.

http://www.chez.com/alors/
