Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbWE3Viq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbWE3Viq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 17:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWE3Viq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 17:38:46 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:13971 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932494AbWE3Vip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 17:38:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Un7OPqi0pBw7Nfg66K8MHsewFUNHnSKM6miliSMJODz5T8UzyrXWoJvELmNueGsVdYIPwt88kq7FDa5i+bAiD85F7D/slpYuw73e6oS9Z837ZUGWdOgTARNm9nrsT830xjgCvVCV9LZxIEAOu1DNj6zOhVGZpTD76BsA9PMR1IM=
Message-ID: <4d8e3fd30605301438k457f6242x1df64df9bab7f8f1@mail.gmail.com>
Date: Tue, 30 May 2006 23:38:44 +0200
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
To: "Jens Axboe" <axboe@suse.de>
Subject: Re: [PATCH] fcache: a remapping boot cache
Cc: linux-kernel@vger.kernel.org, mason@suse.com
In-Reply-To: <20060516074628.GA16317@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060515091806.GA4110@suse.de> <20060515101019.GA4068@suse.de>
	 <20060516074628.GA16317@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/06, Jens Axboe <axboe@suse.de> wrote:
> On Mon, May 15 2006, Jens Axboe wrote:
> > On Mon, May 15 2006, Jens Axboe wrote:
> > > o Trying it on my notebook brought the time from the kernel starts
> > >   loading to kde has fully auto-logged in down from 50 seconds to 38
> > >   seconds. The primed boot took 61 seconds. The notebook is about 4
> > >   months old and the file system is very fresh, so better results should
> > >   be seen on more fragmented installs.
> >
[...]
> git://brick.kernel.dk/data/git/linux-2.6-block.git fcache

Just cloned.

Any progress on this project Jens?

I'll try to apply the patch to mainline and post here some numbers.

Ciao,
-- 
Paolo
http://paolociarrocchi.googlepages.com
