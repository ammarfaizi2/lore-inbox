Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965034AbVIOEMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbVIOEMp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 00:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965257AbVIOEMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 00:12:45 -0400
Received: from nome.ca ([65.61.200.81]:19131 "HELO gobo.nome.ca")
	by vger.kernel.org with SMTP id S965034AbVIOEMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 00:12:45 -0400
Date: Wed, 14 Sep 2005 21:13:34 -0700
From: Mike Bell <mike@mikebell.org>
To: Robert Love <rml@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev FAQ from the other side
Message-ID: <20050915041334.GJ15017@mikebell.org>
Mail-Followup-To: Mike Bell <mike@mikebell.org>,
	Robert Love <rml@novell.com>, linux-kernel@vger.kernel.org
References: <20050915005105.GD15017@mikebell.org> <1126746518.9652.60.camel@phantasy> <20050915020935.GF15017@mikebell.org> <1126754270.9652.64.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126754270.9652.64.camel@phantasy>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 11:17:50PM -0400, Robert Love wrote:
> If you can survive without modernism,

Features I don't need are "modernism"? Who defines what's "modern" and
what's merely "useless"? Some things in newer kernels are very, very
useful. Even sysfs is useful on some of my systems. But no, I generally
try to avoid turning on features that I'm not even going to use on a
given system. Do you install things you're not going to use on your
machines? Maybe two or three different SQL servers, just to be
extra-modern? Especially when I'm paying for every megabyte of flash x1k
or x10k, I don't want to waste it on a bunch of unused kernel->userspace
interfaces just to prove how incredibly hip to the latest linux fads I
am.

> why can't you survive without devfs?  Why do you need it?

Why can't you read any of the many threads on this subject where I
explained this already? :)

devfs's removal from the kernel isn't going to end my life, no. In fact
it won't even stop me using linux. But it makes my job harder and more
expensive, and as my little FAQ explains I don't feel I'm getting
anything out of the deal (remember, udev's naming features are different
to udev's device node creation, there's no reason you can't have one
without the other).
