Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbTHUXQK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 19:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbTHUXQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 19:16:10 -0400
Received: from almesberger.net ([63.105.73.239]:32778 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262165AbTHUXQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 19:16:07 -0400
Date: Thu, 21 Aug 2003 20:15:44 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Bryan O'Sullivan" <bos@serpentine.com>, gkajmowi@tbaytel.net,
       linux-kernel@vger.kernel.org
Subject: Re: Initramfs
Message-ID: <20030821201544.B1212@almesberger.net>
References: <200308210044.17876.gkajmowi@tbaytel.net> <1061447419.19503.20.camel@camp4.serpentine.com> <3F44D504.7060909@pobox.com> <20030821193113.A3448@almesberger.net> <3F454AA5.3000602@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F454AA5.3000602@pobox.com>; from jgarzik@pobox.com on Thu, Aug 21, 2003 at 06:41:41PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> initramfs _must_ act like a file system ;-)

Yes, yes :-) I mean, not only during operation, but also when
initializing (i.e. that it loads its data from a block device).

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
