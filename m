Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272856AbRIGVbk>; Fri, 7 Sep 2001 17:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272860AbRIGVba>; Fri, 7 Sep 2001 17:31:30 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:17673 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272856AbRIGVbU>; Fri, 7 Sep 2001 17:31:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        riel@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Defragmentation proposal: preventative maintenance and cleanup [LONG]
Date: Fri, 7 Sep 2001 23:38:42 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
In-Reply-To: <1426827386.999856726@[169.254.198.40]> <1427827800.999857726@[169.254.198.40]>
In-Reply-To: <1427827800.999857726@[169.254.198.40]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010907213131Z16325-26183+206@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 7, 2001 11:15 am, Alex Bligh - linux-kernel wrote:
> >> It becomes effectively useless.  The probability of all 8 pages of a given
> The chance of seeing more than 500 events of probability
> p = 2.5 ^ (10^-6) across 32000 samples, is vanishingly
> small. Yet it looks this way all the time.
> 
> Hence I conclude your model is wrong :-)

True.  OK, need to make a better model, time to crack my Knuth.

--
Daniel
