Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132530AbRDQDcK>; Mon, 16 Apr 2001 23:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132531AbRDQDcB>; Mon, 16 Apr 2001 23:32:01 -0400
Received: from rdu162-245-038.nc.rr.com ([24.162.245.38]:43136 "EHLO
	rdu162-245-038.nc.rr.com") by vger.kernel.org with ESMTP
	id <S132530AbRDQDbq>; Mon, 16 Apr 2001 23:31:46 -0400
Message-ID: <3ADBB8C9.CC7FD941@nc.rr.com>
Date: Mon, 16 Apr 2001 23:30:17 -0400
From: Chris Kloiber <ckloiber@nc.rr.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2-athlon i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Documentation of module parameters.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was recently looking for a single location where all the possible
module parameters for the linux kernel was located.

I figured I would look at the source first, hoping that each module
maintaier would clearly document at the beginning of each .c file all of
the parameters his or her module can accept. Sadly, that's not always
the case. Some modules are well documented, others are a complete
mystery. If I was a programmer myself, I might be able to determine from
the code itself what parameters are possible, but that's not one of my
talents. Could any and all of you please take the time to document your
code, and keep the comments up to date when it changes? I think that in
the source code itself is the best place for such documentation, as you
have the chance to fix the docs with every patch, and the source is
always included in each distribution. Then from the source can any
exterior documentation be gleaned. Those of us who don't speak C would
really appreciate it. 

Thanks In Advance.

Chris Kloiber
