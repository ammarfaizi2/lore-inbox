Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269424AbUINRK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269424AbUINRK0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 13:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269453AbUINRE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 13:04:57 -0400
Received: from [64.65.177.98] ([64.65.177.98]:30656 "EHLO mail.pacrimopen.com")
	by vger.kernel.org with ESMTP id S269460AbUINQne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 12:43:34 -0400
Message-ID: <4146698F.2060305@pacrimopen.com>
Date: Mon, 13 Sep 2004 20:46:23 -0700
From: Joshua Schmidlkofer <kernel@pacrimopen.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040824)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: Con Kolivas <kernel@kolivas.org>, jch@imr-net.com,
       ck kernel mailing list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Cliff Wells <clifford.wells@comcast.net>
Subject: Re: [ck] Re: 2.6.8.1-ck7, Two Badnessess, one dump.
References: <41412765.4010005@kolivas.org> <4144F691.6040405@pacrimopen.com> <41451957.7000101@kolivas.org> <4145BAE9.1040800@pacrimopen.com> <20040913191237.GF18883@suse.de>
In-Reply-To: <20040913191237.GF18883@suse.de>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is your drive idle while applying dma settings? Current 2.6 kernels
> aren't even close to being safe to modify drive settings, since it makes
> no effective attempts to serialize with ongoing commands. I have a
> half-assed patch to fix that.

1.  Sorry about the HTML

2.  How half-assed is the patch / what is it likely to break?


js


