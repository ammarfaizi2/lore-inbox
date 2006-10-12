Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWJLUaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWJLUaH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 16:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWJLUaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 16:30:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:9947 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750798AbWJLUaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 16:30:05 -0400
Message-ID: <474c7c2f0610121330x10f1148epb37c1acb7ceb762c@mail.gmail.com>
Date: Thu, 12 Oct 2006 16:30:03 -0400
From: "=?UTF-8?Q?G=C3=BCnther_Starnberger?=" <gst@sysfrog.org>
To: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Userspace process may be able to DoS kernel
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1160668290.24931.31.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <474c7c2f0610110954y46b68a14q17b88a5e28ffe8d9@mail.gmail.com>
	 <1160668290.24931.31.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/06, Lee Revell <rlrevell@joe-job.com> wrote:

> Do you get the same behavior using the old OSS drivers that you get with
> ALSA's OSS emulation?

Yes. I've rmmod'ed ALSA and used the i810_audio OSS module instead.
Same problem.

bye,
/gst
