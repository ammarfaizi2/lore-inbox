Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265610AbSKAEqw>; Thu, 31 Oct 2002 23:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265614AbSKAEqw>; Thu, 31 Oct 2002 23:46:52 -0500
Received: from almesberger.net ([63.105.73.239]:5384 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265610AbSKAEqv>; Thu, 31 Oct 2002 23:46:51 -0500
Date: Fri, 1 Nov 2002 01:53:08 -0300
From: Werner Almesberger <wa@almesberger.net>
To: shuey@purdue.edu
Cc: Vagn Scott <vagn@ranok.com>, linux-kernel@vger.kernel.org
Subject: Re: What's left over. 700 1-port console server
Message-ID: <20021101015308.E2599@almesberger.net>
References: <3DC1FDC2.8E64C099@ranok.com> <20021101043237.GC11169@lucky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021101043237.GC11169@lucky>; from shuey@fmepnet.org on Thu, Oct 31, 2002 at 11:32:37PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Shuey wrote:
> And how, praytell, am I supposed to do that when most of my cluster nodes
> only have one (1) serial port?

That's plenty. The RX wire and the TX wire don't have to go to the
same machine :-))

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
