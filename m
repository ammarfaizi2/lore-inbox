Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263822AbUDPWmn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 18:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263916AbUDPWmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 18:42:23 -0400
Received: from mail.shareable.org ([81.29.64.88]:56738 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263822AbUDPWf6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 18:35:58 -0400
Date: Fri, 16 Apr 2004 23:35:48 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
Message-ID: <20040416223548.GA27540@mail.shareable.org>
References: <1080771361.1991.73.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080771361.1991.73.camel@sisko.scot.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie wrote:
> I've been looking at a discrepancy between msync() behaviour on 2.4.9
> and newer 2.4 kernels, and it looks like things changed again in
> 2.5.68.

When you say a discrepancy between 2.4.9 and newer 2.4 kernels, do you
mean that the msync() behaviour changed during the 2.4 series?

If so, what was the change?

Thanks,
-- Jamie
