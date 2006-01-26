Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWAZAxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWAZAxJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 19:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWAZAxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 19:53:09 -0500
Received: from are.twiddle.net ([64.81.246.98]:58516 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S932239AbWAZAxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 19:53:07 -0500
Date: Wed, 25 Jan 2006 16:52:56 -0800
From: Richard Henderson <rth@twiddle.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] alpha: Fix getxpid on alpha so it works for threads.
Message-ID: <20060126005256.GB5592@twiddle.net>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <m1vew8i0vd.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1vew8i0vd.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 12:05:58PM -0700, Eric W. Biederman wrote:
> The following (untested) patch should fix the problem.

Looks good; well spotted.


r~
