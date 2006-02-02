Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161003AbWBBAwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161003AbWBBAwp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 19:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030380AbWBBAwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 19:52:45 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:47310 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030241AbWBBAwp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 19:52:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LCdhgKnu8p00L2LNjHi8y3quoin3pPI5VkWas+DvRzFomuzBh3931s9GqVTtgCCNljyMTh72/OMq1V7oYyg5jPHLn9Si77R13VF5Zt4475zA/b53loB8gCf4XA3Co9WhNuAYVOePrlC+SkSigPGFbx+a0315q2Z/OJ5d+mbvXJc=
Message-ID: <7f45d9390602011652w797afb93kbb24c84522d2f2aa@mail.gmail.com>
Date: Wed, 1 Feb 2006 17:52:44 -0700
From: Shaun Jackman <sjackman@gmail.com>
Reply-To: Shaun Jackman <sjackman@gmail.com>
To: Jiri Slaby <xslaby@fi.muni.cz>
Subject: Re: Liyitec PS/2 touch panel driver [PATCH]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060201010355.D5D6D22AEF3@anxur.fi.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7f45d9390601311459o45de3c34sd4d25fc7990c728d@mail.gmail.com>
	 <20060201010355.D5D6D22AEF3@anxur.fi.muni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/06, Jiri Slaby <xslaby@fi.muni.cz> wrote:
> It would be great to use dev_*() rather than printks.
> dev_dbg(&serio->dev, "unsynchronized data: 0x%02x\n", data);
> for instance.

Thanks, Jiri. Will do.

Cheers,
Shaun
