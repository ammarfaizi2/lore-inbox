Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280583AbRLHNwH>; Sat, 8 Dec 2001 08:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280592AbRLHNv6>; Sat, 8 Dec 2001 08:51:58 -0500
Received: from ns.suse.de ([213.95.15.193]:63239 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S280583AbRLHNvt>;
	Sat, 8 Dec 2001 08:51:49 -0500
Date: Sat, 8 Dec 2001 14:51:46 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: James Stevenson <mistral@stev.org>
Cc: Rob Fulton <rob@cow-frenzy.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Bad EIP value on 2.4.16
In-Reply-To: <008201c17feb$2badd820$0801a8c0@Stev.org>
Message-ID: <Pine.LNX.4.33.0112081451170.10686-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Dec 2001, James Stevenson wrote:

> > Dec  8 12:20:09 scutter kernel: EIP:    0010:[<0000b600>]    Not tainted
> i have never seen this before until yesterday until 2.4.14 did an opps on me
> what is the Not tainted mean ?

See the bottom of Documentation/oops-tracing.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

