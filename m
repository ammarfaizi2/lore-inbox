Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQKMXfj>; Mon, 13 Nov 2000 18:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129478AbQKMXf2>; Mon, 13 Nov 2000 18:35:28 -0500
Received: from mhaaksma-3.dsl.speakeasy.net ([64.81.17.226]:29712 "EHLO
	mail.neruo.com") by vger.kernel.org with ESMTP id <S129210AbQKMXfR>;
	Mon, 13 Nov 2000 18:35:17 -0500
Subject: Re: APM oops with Dell 5000e laptop
From: Brad Douglas <brad@neruo.com>
To: Dax Kelson <dax@gurulabs.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.30.0011131537460.27682-100000@ultra1.inconnect.com>
Content-Type: text/plain
X-Mailer: Evolution 0.6 (Developer Preview)
Date: 14 Nov 2000 07:04:55 +0800
Mime-Version: 1.0
Message-Id: <20001113233519Z129210-521+38@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I just got a Sceptre 6950 (also known as a Dell 5000e), I just installed
> Red Hat 7.0 on it, and got an APM related oops at boot.
> 
> I found that this was reported on l-k in late September with a couple
> responses, but no resolution.
> 
> Here are a couple detailed bug reports on this same problem, again with no
> response.
> 
> http://linuxcare.com.au/cgi-bin/apm/incoming?id=90
> http://linuxcare.com.au/cgi-bin/apm/incoming?id=91

We have an open ticket with Compal (the manufacturer) about the problem.  The 32-bit Get Power Status (0AH) call is broken.

Brad Douglas
brad@tuxtops.com
http://www.tuxtops.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
