Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279642AbRJ2Xvk>; Mon, 29 Oct 2001 18:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279641AbRJ2Xvf>; Mon, 29 Oct 2001 18:51:35 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:23074 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S279642AbRJ2XvW>; Mon, 29 Oct 2001 18:51:22 -0500
Date: Mon, 29 Oct 2001 18:51:58 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
Message-ID: <20011029185158.L25434@redhat.com>
In-Reply-To: <20011029183927.J25434@redhat.com> <Pine.LNX.4.33.0110291541140.16703-100000@penguin.transmeta.com> <20011029184821.K25434@redhat.com> <20011029.155056.23033599.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011029.155056.23033599.davem@redhat.com>; from davem@redhat.com on Mon, Oct 29, 2001 at 03:50:56PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 03:50:56PM -0800, David S. Miller wrote:
> 
> Numbers talk, bullshit walks.

There is a correct way to do this optimization.  If you're enough of an asshole 
to not care about doing it that way, great!

		-ben
