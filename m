Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422864AbWJLQzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422864AbWJLQzJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 12:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422868AbWJLQzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 12:55:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:36675 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422865AbWJLQzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 12:55:03 -0400
Message-ID: <474c7c2f0610120955ma1850b4lf20ac1f826ff4a35@mail.gmail.com>
Date: Thu, 12 Oct 2006 12:55:01 -0400
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

No - not yet. The problem occurs when I use ALSA directly as well as
with ALSA's OSS emulation.

I will check if there is an OSS driver for my soundcard so that I can
try this out.

bye,
/gst
