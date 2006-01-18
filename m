Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030355AbWARTKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030355AbWARTKb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 14:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbWARTKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 14:10:31 -0500
Received: from xproxy.gmail.com ([66.249.82.198]:39380 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030355AbWARTKa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 14:10:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aZ3QNiqY/IbwFzy8eHiSJnaPtOrk+YAjmW6b7VZboWvkJEchQLehw92+SctAdnb09ONh2akWQOkLaE2FG6kSYBFnIOaWG8iPcWfXui/EV765pxo9rZRa/sLQKpQWH/pIr7bpbAQmA8DI1gN/zm6QCcjpffxGEOzIUe6MX81I2NI=
Message-ID: <4807377b0601181110y72e1e4f2w8337c559713f2da4@mail.gmail.com>
Date: Wed, 18 Jan 2006 11:10:29 -0800
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] e1000 C style badness
Cc: Jeff Garzik <jgarzik@pobox.com>, Jon Smirl <jonsmirl@gmail.com>,
       jeffrey.t.kirsher@intel.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060118182012.GR4222@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060118080738.GD3945@suse.de> <20060118083721.GA4222@suse.de>
	 <9e4733910601180953i11963df9n232cd8980c4bf7f2@mail.gmail.com>
	 <43CE8567.5040205@pobox.com> <20060118182012.GR4222@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/06, Jens Axboe <axboe@suse.de> wrote:
> On Wed, Jan 18 2006, Jeff Garzik wrote:
> > We'll get it fixed ASAP, even if it means reverting all those patches.
>
> Thanks, it is rather critical. At least it didn't get included in -rc1,
> that would have been a disaster :-)

just FYI, I have a patch for the e1000 breakage which will be out as
soon as I can generate it.

Jesse
