Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbSLJRJx>; Tue, 10 Dec 2002 12:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262506AbSLJRJx>; Tue, 10 Dec 2002 12:09:53 -0500
Received: from mail1.dac.neu.edu ([129.10.1.75]:519 "EHLO mail1.dac.neu.edu")
	by vger.kernel.org with ESMTP id <S262492AbSLJRJw>;
	Tue, 10 Dec 2002 12:09:52 -0500
Message-ID: <3DF621D0.6040505@ccs.neu.edu>
Date: Tue, 10 Dec 2002 12:18:08 -0500
From: Stan Bubrouski <stan@ccs.neu.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.51 with contest
References: <200212102245.19862.conman@kolivas.net>
In-Reply-To: <200212102245.19862.conman@kolivas.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Here are contest results (http://contest.kolivas.net) for 2.5.51 and related 
> kerneles using the dedicated osdl (http://www.osdl.org) hardware. 
> 
> Uniprocessor:
> noload:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.5.49 [5]              70.0    96      0       0       1.05
> 2.5.50 [5]              69.9    96      0       0       1.05
> 2.5.50-mm1 [5]          71.4    94      0       0       1.07
> 2.5.51 [2]              69.8    96      0       0       1.05

I know this has been brought up before, but
these don't seem to mean much unless you
include 2.4.20 in the comaprison.

-Stan

