Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269021AbRHPX3s>; Thu, 16 Aug 2001 19:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268971AbRHPX3j>; Thu, 16 Aug 2001 19:29:39 -0400
Received: from ool-18b899e0.dyn.optonline.net ([24.184.153.224]:47099 "EHLO
	bouncybouncy") by vger.kernel.org with ESMTP id <S269064AbRHPX3d>;
	Thu, 16 Aug 2001 19:29:33 -0400
Date: Thu, 16 Aug 2001 19:29:46 -0400
From: Justin A <justin@bouncybouncy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: VM nuisance
Message-ID: <20010816192946.A20072@bouncybouncy.net>
In-Reply-To: <Pine.LNX.4.33.0108121506100.18332-100000@druid.if.uj.edu.pl> <Pine.LNX.4.33L.0108121045090.6118-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0108121045090.6118-100000@imladris.rielhome.conectiva>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2001 at 10:45:40AM -0300, Rik van Riel wrote:
> On Sun, 12 Aug 2001, Maciej Zenczykowski wrote:
> 
> > How about adding some sort of per-process priority (i.e. a la nice) which
> 
> That's not the problem. The killing itself is going
> pretty well.
> 
> The problem is to decide WHEN to kill a process.
> 
> regards,
> 
> Rik

Though it is not a complete solution for all cases(servers etc),
could a SysReq combination be added that triggers OOM?  I'm sure many
people use SysReq-k on occasion to get a system out of endless
swapping,  I think having a SysReq key for OOM would be a great
improvement.

Comments?
-Justin
