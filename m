Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314907AbSD2InC>; Mon, 29 Apr 2002 04:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314908AbSD2InB>; Mon, 29 Apr 2002 04:43:01 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:5616 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S314907AbSD2InB>; Mon, 29 Apr 2002 04:43:01 -0400
Date: Mon, 29 Apr 2002 01:42:37 -0700
From: Chris Wright <chris@wirex.com>
To: Soeren Sonnenburg <sonnenburg@informatik.hu-berlin.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: getting a programs ENV via ptrace ?
Message-ID: <20020429014237.C8654@figure1.int.wirex.com>
Mail-Followup-To: Soeren Sonnenburg <sonnenburg@informatik.hu-berlin.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1020068756.5050.7.camel@sun>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Soeren Sonnenburg (sonnenburg@informatik.hu-berlin.de) wrote:
> Hi...
> 
> I am looking for a way of getting the environment variables of a running
> process.
> 
> Is this possible by using the ptrace interface somehow ?
> 
> Thanks for any suggestions / pointers are welcome !

What about just using /proc/[pid]/environ?

cheers,
-chris
