Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277547AbRJKACq>; Wed, 10 Oct 2001 20:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277541AbRJKACg>; Wed, 10 Oct 2001 20:02:36 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:22525 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S277547AbRJKACb>; Wed, 10 Oct 2001 20:02:31 -0400
Date: Wed, 10 Oct 2001 17:00:25 -0700
From: Chris Wright <chris@wirex.com>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.11 min() in tcp.c
Message-ID: <20011010170025.G21401@figure1.int.wirex.com>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20011010164430.B19995@figure1.int.wirex.com> <20011010.165659.74564935.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011010.165659.74564935.davem@redhat.com>; from davem@redhat.com on Wed, Oct 10, 2001 at 04:56:59PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David S. Miller (davem@redhat.com) wrote:
> 
> Applied, but with a cleanup, please never do this:
>    
>    -		min(
>    +		min_t (

yes, my mistake. thanks.
-chris
