Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbUBGXpd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 18:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbUBGXpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 18:45:32 -0500
Received: from almesberger.net ([63.105.73.238]:19729 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261492AbUBGXpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 18:45:31 -0500
Date: Sat, 7 Feb 2004 20:45:22 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VFS locking: f_pos thread-safe ?
Message-ID: <20040207204521.G18820@almesberger.net>
References: <20040206041223.A18820@almesberger.net> <20040206215451.A2978@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040206215451.A2978@pclin040.win.tue.nl>; from aebr@win.tue.nl on Fri, Feb 06, 2004 at 09:54:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> The 2003 version can be found at
> 
> http://www.opengroup.org/onlinepubs/007904975/toc.htm
> http://www.opengroup.org/onlinepubs/007904975/functions/xsh_chap02_09.html

Thanks a lot !

The wording is the same, so it seems that we don't comply with
that part, at least not in the letter :-(

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
