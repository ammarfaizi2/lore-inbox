Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272758AbRIGQZ5>; Fri, 7 Sep 2001 12:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272763AbRIGQZq>; Fri, 7 Sep 2001 12:25:46 -0400
Received: from cs173101.pp.htv.fi ([213.243.173.101]:6970 "EHLO
	porkkala.cs173101.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S272758AbRIGQZj>; Fri, 7 Sep 2001 12:25:39 -0400
Message-ID: <3B98F503.14A1E725@pp.htv.fi>
Date: Fri, 07 Sep 2001 19:25:39 +0300
From: Jussi Laako <jlaako@pp.htv.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: tegeran@home.com
CC: linux-kernel@vger.kernel.org
Subject: Re: K7/Athlon optimizations and Sacrifices to the Great Ones.
In-Reply-To: <01090612513601.00171@c779218-a>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Knight wrote:
> 
> problem on the SAME physical board, just two different processors. Both
> 6-4-2, the only difference is that one is 1.13Ghz and doesn't have the
> problem, and the other is 1.2Ghz and DOES have the problem. This of
> course leads me back to the clock speed theory, but again it doesn't make
> any SENSE because the FSB on both of them is 133Mhz and I've got at least
> two reports of 1.33Ghz chips running FINE! ARG!

How about the synchronization issue that came up in the power saving thread?
Some bus synchronization problem (integer/non-integer multiplier)?

 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
