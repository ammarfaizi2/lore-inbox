Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161230AbWATGr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161230AbWATGr3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 01:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161233AbWATGr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 01:47:29 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:37863 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1161230AbWATGr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 01:47:28 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: 2.6.16-rc1-git1 -- Build error "make: *** [include/linux/version.h] Error 2"
Date: Fri, 20 Jan 2006 16:43:29 +1000
User-Agent: KMail/1.9.1
Cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>
References: <a44ae5cd0601182247h1b173289ncbc6dc405cbb0bb4@mail.gmail.com> <a44ae5cd0601190115y6f6e93a1y6b6b6284280259fd@mail.gmail.com> <20060119092320.GA8588@mars.ravnborg.org>
In-Reply-To: <20060119092320.GA8588@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601201643.29207.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thursday 19 January 2006 19:23, Sam Ravnborg wrote:
> This can also be a side-effect of /dev/null being damaged.

I had precisely this problem last night. No idea what caused it, but that was 
the issue. Wish I'd seen your email before I wasted time finding the 
cause! :)

Nigel
