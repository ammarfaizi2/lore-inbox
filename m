Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422793AbWJPSfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422793AbWJPSfp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 14:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422786AbWJPSfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 14:35:45 -0400
Received: from colin.muc.de ([193.149.48.1]:55566 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1422793AbWJPSfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 14:35:44 -0400
Date: 16 Oct 2006 20:35:42 +0200
Date: Mon, 16 Oct 2006 20:35:42 +0200
From: Andi Kleen <ak@muc.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Yinghai Lu <yinghai.lu@amd.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       yhlu.kernel@gmail.com
Subject: Re: Fwd: [PATCH] x86_64: typo in __assign_irq_vector when update pos for vector and offset
Message-ID: <20061016183542.GA41969@muc.de>
References: <86802c440610150029k28957786v3b313e29f1f52c8@mail.gmail.com> <86802c440610151221v2217cb67t354e1ccbcee54b6a@mail.gmail.com> <86802c440610160826g6b918d9bh65948d49f668e892@mail.gmail.com> <m1zmbwb0gg.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1zmbwb0gg.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 12:05:35PM -0600, Eric W. Biederman wrote:
> For 2.6.19 we should be able to get my typos fixed, and probably
> the default mask increased so that we are given a choice of something
> other than cpu 0.
> 
> Beyond that it is going to take some additional working and thinking
> and so it probably makes sense to have the code sit in the -mm
> or Andi's tree for a while, and let it mature for 2.6.20.

I admit I lost track of the patches for this new code which went
in while I was away.

Is that the only patch needed or are there other known problems too?

-Andi
