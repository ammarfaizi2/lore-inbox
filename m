Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263144AbVGaAkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263144AbVGaAkU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 20:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbVGaAkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 20:40:20 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:48825 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263144AbVGaAkS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 20:40:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QusCIuC8v8b99BhJWffQcvZ08IljQigbpMsJfFoZL5RYV4P0MZSXXhYMHx4+E3kZA8P7c1CDsQBULc55mjhaspEWwx2NpuFy7Dsn9+EyLomTKlfjTvgsDINcQGUQcUWUunggX93dM2z0oO0yTX/LJ8r8yGVh5AoeuC6GTnDo2K0=
Message-ID: <21d7e997050730174034a68f4@mail.gmail.com>
Date: Sun, 31 Jul 2005 10:40:18 +1000
From: Dave Airlie <airlied@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Simple question re: oops
Cc: Alexander Nyberg <alexn@telia.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1122769290.4464.12.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1122767292.4464.1.camel@mindpipe>
	 <20050731001101.GA6762@localhost.localdomain>
	 <1122769290.4464.12.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> panic_on_oops has no effect, a bunch of stuff flies past and the last
> thing I see is "gam_server: scheduling while atomic" then a stack trace
> of the core dump path then "Aiee, killing interrupt handler".
> 
> I am starting to suspect the hard drive, does that sound plausible?
> It's as if it locks up when it hits a certain disk block.

run memtest on it... you might have bad RAM..

Dave.
