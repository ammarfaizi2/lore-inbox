Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135993AbRDTTV2>; Fri, 20 Apr 2001 15:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135994AbRDTTVS>; Fri, 20 Apr 2001 15:21:18 -0400
Received: from goat.cs.wisc.edu ([128.105.166.42]:49676 "EHLO goat.cs.wisc.edu")
	by vger.kernel.org with ESMTP id <S135993AbRDTTVJ>;
	Fri, 20 Apr 2001 15:21:09 -0400
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org, pcroth@cs.wisc.edu, epaulson@cs.wisc.edu
Subject: Re: BUG: Global FPU corruption in 2.2
In-Reply-To: <Pine.LNX.3.95.1010420145755.11087A-100000@chaos.analogic.com>
From: Victor Zandy <zandy@cs.wisc.edu>
Date: 20 Apr 2001 14:20:52 -0500
In-Reply-To: "Richard B. Johnson"'s message of "Fri, 20 Apr 2001 15:07:28 -0400 (EDT)"
Message-ID: <cpx3db3z8bv.fsf@goat.cs.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


No dice.  Your program does not fix the problem.

If it were a hardware problem, I would expect the problem to occur
under 2.4.2 as well as 2.2.*, and I would be surprised that we can
consistently produce the behavior across our 64 node cluster.  But we
are keeping the possibility in mind.

Thanks for your suggestions.

Vic
