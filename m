Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262992AbSJBIAC>; Wed, 2 Oct 2002 04:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262997AbSJBIAC>; Wed, 2 Oct 2002 04:00:02 -0400
Received: from tapu.f00f.org ([66.60.186.129]:35753 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S262992AbSJBIAB>;
	Wed, 2 Oct 2002 04:00:01 -0400
Date: Wed, 2 Oct 2002 01:05:30 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Nvidia framebuffer in 2.5
Message-ID: <20021002080530.GA780@tapu.f00f.org>
References: <200210012211.59573.ivg2@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210012211.59573.ivg2@cornell.edu>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 10:11:59PM -0400, Ivan Gyurdiev wrote:

> This stopped working many kernels ago, and I thought perhaps it's
> being converted to a different API... but it hasn't been fixed
> yet..is it a bug?

That are patches floating about to make it work for 2.5.x; however it
has some 'schedule while holding locks' issues which may not be fixed
anytime soon.

Bug nVIDIA :)



  --cw
