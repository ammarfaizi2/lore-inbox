Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbUCJTjA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 14:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbUCJTgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 14:36:39 -0500
Received: from holomorphy.com ([207.189.100.168]:44557 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262801AbUCJTf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 14:35:59 -0500
Date: Wed, 10 Mar 2004 11:35:54 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Miek Gieben <miekg@atoom.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pts/X counts on
Message-ID: <20040310193554.GM655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Miek Gieben <miekg@atoom.net>, linux-kernel@vger.kernel.org
References: <20040310190902.GA2226@atoom.net> <20040310192415.GL655@holomorphy.com> <20040310193340.GB2278@atoom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310193340.GB2278@atoom.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[On 10 Mar, @20:24, William wrote in "Re: pts/X counts on ..."]
>> This change in behavior was intentional. It should not affect your
>> applications. The change was part of a patch that made pty's
>> completely dynamic.

On Wed, Mar 10, 2004 at 08:33:40PM +0100, Miek Gieben wrote:
> ah, it's a feature :-) But I'm not seeing it on all my systems....(running
> 2.6.3)
> Thanks,
> grtz Miek

Odd. Maybe it's -mm vs. non -mm.


-- wli
