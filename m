Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbVIEDIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbVIEDIn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 23:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbVIEDIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 23:08:43 -0400
Received: from mail.autoweb.net ([198.172.237.26]:16028 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S932172AbVIEDIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 23:08:42 -0400
Date: Sun, 4 Sep 2005 23:08:28 -0400
From: Ryan Anderson <ryan@michonline.com>
To: Miles Lane <miles.lane@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       "James P. Ketrenos" <ipw2100-admin@linux.intel.com>
Subject: Re: Old ipw2200 code in 2.6.13-git3 and 2.6.13-mm1
Message-ID: <20050905030828.GB5335@mythryan2.michonline.com>
References: <a44ae5cd050902204854687377@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44ae5cd050902204854687377@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2005 at 08:48:28PM -0700, Miles Lane wrote:

[snip]

> Can we please get the latest IPW2200 code into the development kernels soon?

Seconded.  I haven't rebuilt the 1.0.6 code against the 2.6.13-git
kernels, but my 2.6.13-rc4 build with 1.0.6 ipw2200 in it seems much
more stable and dependable at starting up a network than
2.6.13-git-current does.

(For example, I had to do a full power-cycle to get things working again
after I ran into a "failed to send TX_POWER" issue - I've never seen
that before, but I've never run the 1.0.0 driver before today.)

-- 

Ryan Anderson
  sometimes Pug Majere
