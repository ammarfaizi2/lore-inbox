Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277777AbRJIPft>; Tue, 9 Oct 2001 11:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277776AbRJIPf3>; Tue, 9 Oct 2001 11:35:29 -0400
Received: from ns.ithnet.com ([217.64.64.10]:34319 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S277774AbRJIPfZ>;
	Tue, 9 Oct 2001 11:35:25 -0400
Date: Tue, 9 Oct 2001 17:22:40 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "G. Hugh Song" <hugh@bellini.kjist.ac.kr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM-related freeze of UP2000SMP using 2.4.11-pre3aa1
Message-Id: <20011009172240.229db2f2.skraw@ithnet.com>
In-Reply-To: <200110091506.f99F68P12059@bellini.kjist.ac.kr>
In-Reply-To: <200110091506.f99F68P12059@bellini.kjist.ac.kr>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2001 00:06:08 +0900 "G. Hugh Song" <hugh@bellini.kjist.ac.kr>
wrote:

> 
> [...]
> I wish I could confirm that the current problem is due to the new 
> kernel.  Was there any known vm-related bug in 2.4.11-pre3aa1?

I can't exactly confirm for pre3aa1, but pre3/pre4 has a vm deadlock. Please
try pre6.

Regards,
Stephan

