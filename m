Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285165AbRLRVFN>; Tue, 18 Dec 2001 16:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285161AbRLRVFH>; Tue, 18 Dec 2001 16:05:07 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23301 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S285166AbRLRVEg>; Tue, 18 Dec 2001 16:04:36 -0500
Date: Tue, 18 Dec 2001 21:03:32 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: kuznet@ms2.inr.ac.ru
Cc: Mika Liljeberg <Mika.Liljeberg@welho.com>, Mika.Liljeberg@nokia.com,
        davem@redhat.com, linux-kernel@vger.kernel.org,
        sarolaht@cs.helsinki.fi
Subject: Re: ARM: Re: TCP LAST-ACK state broken in 2.4.17-pre2 [NEW DATA]
Message-ID: <20011218210332.D13126@flint.arm.linux.org.uk>
In-Reply-To: <3C1FA558.E889A00D@welho.com> <200112182029.XAA11287@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200112182029.XAA11287@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Tue, Dec 18, 2001 at 11:29:06PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2001 at 11:29:06PM +0300, kuznet@ms2.inr.ac.ru wrote:
> > It's ARM in little endian mode.
> 
> I think it is answer to the question.
> 
> No doubts it still has broken misaligned access.

You're way out of line with that comment.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

