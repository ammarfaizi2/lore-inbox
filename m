Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289631AbSAOUVA>; Tue, 15 Jan 2002 15:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290273AbSAOUUu>; Tue, 15 Jan 2002 15:20:50 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:2136 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S290270AbSAOUUm>; Tue, 15 Jan 2002 15:20:42 -0500
Date: Tue, 15 Jan 2002 15:20:38 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Hubertus Franke <frankeh@watson.ibm.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] zerocopy pipe, new version
Message-ID: <20020115152038.G6853@redhat.com>
In-Reply-To: <002701c19638$400f15f0$010411ac@local> <011001c19de8$ec1d4800$1cdb0209@diz.watson.ibm.com> <20020115145747.F6853@redhat.com> <001801c19e00$71c355a0$010411ac@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <001801c19e00$71c355a0$010411ac@local>; from manfred@colorfullife.com on Tue, Jan 15, 2002 at 09:08:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 09:08:45PM +0100, Manfred Spraul wrote:
> My patch is definitively WIP - right now I again broke the -ENOMEM and
> -EFAULT handling.

I am aware of that, but the lse-tech posting made it sound as if things are 
great now since the SMP numbers improved.  Please folks, remember that UP 
numbers are important too.

		-ben
-- 
Fish.
