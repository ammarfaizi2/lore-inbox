Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131976AbRDNXej>; Sat, 14 Apr 2001 19:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132125AbRDNXe3>; Sat, 14 Apr 2001 19:34:29 -0400
Received: from relay.freedom.net ([207.107.115.209]:18950 "HELO relay")
	by vger.kernel.org with SMTP id <S131976AbRDNXeR>;
	Sat, 14 Apr 2001 19:34:17 -0400
X-Freedom-Envelope-Sig: linux-kernel@vger.kernel.org AQGHVsjK7CtTZHSbyjOzjlecCKGe59aI9itYgrYbGz8P1ZdySWU8JZ7s
Date: Sat, 14 Apr 2001 17:33:02 -0600
Old-From: cacook@freedom.net
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: DPT PM3755F Fibrechannel Host Adapter
Content-Type: text/plain; charset = "us-ascii" 
Content-Transfer-Encoding: 7bit
From: cacook@freedom.net
Message-Id: <20010414233426Z131976-682+268@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been unable to set up a module for my DPT fibrechannel host adapter, partly through unavailability, and partly through inexperience.

Found Ricky Beam's 2.4.0-test7 .diff, but lack the experience to retrofit it to 2.4.2. Tried  patch -su <dpt_i2o-test7.diff  to my kernel 2.4.2 source, but many errors not surprisingly.  Tried hand-modifying the files it changes and creating the .c & .h files, but failed there too.

What he made is (an apparently) unified .diff file for an older version of the kernel,
and I would like to get my fibrechannel working as (at least) a module in 2.4.2 and later if possible.
--
C.

The best way out is always through.
      - Robert Frost  A Servant to Servants, 1914

