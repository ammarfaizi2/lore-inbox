Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbSKYGcJ>; Mon, 25 Nov 2002 01:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262480AbSKYGcJ>; Mon, 25 Nov 2002 01:32:09 -0500
Received: from almesberger.net ([63.105.73.239]:65030 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S262469AbSKYGcJ>; Mon, 25 Nov 2002 01:32:09 -0500
Date: Mon, 25 Nov 2002 03:39:06 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: Module Refcount & Stuff mini-FAQ
Message-ID: <20021125033906.B1549@almesberger.net>
References: <20021124230758.A1549@almesberger.net> <20021125055303.484492C055@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021125055303.484492C055@lists.samba.org>; from rusty@rustcorp.com.au on Mon, Nov 25, 2002 at 01:27:02PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> At the cost of exposing the module to initialization races.

Hmm, what races are there that don't correspond to a bug in
some module ?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
