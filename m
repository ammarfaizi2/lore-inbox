Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279630AbRJ2XsK>; Mon, 29 Oct 2001 18:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279350AbRJ2XsA>; Mon, 29 Oct 2001 18:48:00 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:25121 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S279641AbRJ2Xro>; Mon, 29 Oct 2001 18:47:44 -0500
Date: Mon, 29 Oct 2001 18:48:21 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
Message-ID: <20011029184821.K25434@redhat.com>
In-Reply-To: <20011029183927.J25434@redhat.com> <Pine.LNX.4.33.0110291541140.16703-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0110291541140.16703-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Oct 29, 2001 at 03:41:58PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 03:41:58PM -0800, Linus Torvalds wrote:
> Show me a number. Andrea showed his performance. And I claim that our
> "random number generator" is really close to reality.

Please enlighten me why I should go off to do a couple of days work to 
come up with a comparison against a correct version that does the tlb flush 
higher up in the page table walker?  Sorry, but for now I'll stick with 
-ac vm that isn't changing things randomly every release.

		-ben
-- 
Fish.
