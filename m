Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131195AbRACPZL>; Wed, 3 Jan 2001 10:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132266AbRACPZB>; Wed, 3 Jan 2001 10:25:01 -0500
Received: from hermes.mixx.net ([212.84.196.2]:525 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130172AbRACPYz>;
	Wed, 3 Jan 2001 10:24:55 -0500
Message-ID: <3A533C7D.A9C50DB@innominate.de>
Date: Wed, 03 Jan 2001 15:51:41 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-prerelease i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <mikeg@wen-online.de>, linux-kernel@vger.kernel.org
Subject: Re: scheduling problem?
In-Reply-To: <3A52609D.E1D466EA@innominate.de> <Pine.Linu.4.10.10101030545440.1057-100000@mikeg.weiden.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> Semaphore timed out during boot, leaving bdflush as zombie.

Wait a sec, what do you mean by 'semaphore timed out'?  These should
wait patiently forever.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
