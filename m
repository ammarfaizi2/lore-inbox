Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422727AbWATCDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422727AbWATCDO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 21:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422729AbWATCDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 21:03:13 -0500
Received: from twinlark.arctic.org ([207.7.145.18]:9134 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id S1422727AbWATCDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 21:03:13 -0500
Date: Thu, 19 Jan 2006 18:03:10 -0800 (PST)
From: dean gaudet <dean@arctic.org>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Inserting Commas into Those Big Numbers 
In-Reply-To: <43CF1CCF.20007@wolfmountaingroup.com>
Message-ID: <Pine.LNX.4.63.0601191756350.24735@twinlark.arctic.org>
References: <43CF1CCF.20007@wolfmountaingroup.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2006, Jeff V. Merkey wrote:

> If anyone cares to make the kernel output more readable, heres a code snippet
> that formats any text string with numbers (decimal) to
> insert commas.  I am too old and going blind looking at computer screen with
> these long numbers.  If useful to anyone, enjoy.

you know i wish C99 had mandated support for numbers like 1_000_000 or 
0x0123_4567_89ab_cdef.  (not sure if Ada originated this style, but that's 
where i first saw it.)

-dean
