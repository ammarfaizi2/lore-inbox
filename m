Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274752AbRIZAm2>; Tue, 25 Sep 2001 20:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274753AbRIZAmS>; Tue, 25 Sep 2001 20:42:18 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:51701 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S274752AbRIZAmG>; Tue, 25 Sep 2001 20:42:06 -0400
Date: Tue, 25 Sep 2001 17:41:21 -0700
From: Chris Wright <chris@wirex.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: all files are executable in vfat
Message-ID: <20010925174121.A557@figure1.int.wirex.com>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0109251323510.17451-100000@waste.org> <Pine.GSO.4.21.0109251430330.24321-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0109251430330.24321-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Tue, Sep 25, 2001 at 02:34:01PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alexander Viro (viro@math.psu.edu) wrote:
> 
> 
> OK, let me put it that way: we need to turn stat() into method call
> rather than blind access to inode fields.

this would be very useful for lsm.

thanks,
-chris
