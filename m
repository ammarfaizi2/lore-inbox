Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270385AbRHHHYA>; Wed, 8 Aug 2001 03:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270384AbRHHHXo>; Wed, 8 Aug 2001 03:23:44 -0400
Received: from elektra.higherplane.net ([203.37.52.137]:47492 "EHLO
	elektra.higherplane.net") by vger.kernel.org with ESMTP
	id <S270383AbRHHHXe>; Wed, 8 Aug 2001 03:23:34 -0400
Date: Wed, 8 Aug 2001 17:23:59 +1000
From: john slee <indigoid@higherplane.net>
To: Noel Koethe <noel@koethe.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x IP aliase max eth0:16 (16 aliases), where to change?
Message-ID: <20010808172359.B2770@higherplane.net>
In-Reply-To: <Pine.LNX.4.21.0108072238160.20904-100000@data.wipol.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0108072238160.20904-100000@data.wipol.uni-bonn.de>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2001 at 10:41:27PM +0200, Noel Koethe wrote:
> The maximum aliases I can configure with a 2.4.x kernel is 16, right?

$ /sbin/ifconfig -a | grep -c eth0:
55

and i'm an anti-twiddle person.  i've certainly never seen any limit on
this here.  i've heard of people with hundreds or even thousands of
aliases...

j.

-- 
"Bobby, jiggle Grandpa's rat so it looks alive, please" -- gary larson
