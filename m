Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263201AbRE1W30>; Mon, 28 May 2001 18:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263202AbRE1W3Q>; Mon, 28 May 2001 18:29:16 -0400
Received: from yoda.planetinternet.be ([195.95.30.146]:62212 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S263201AbRE1W3H>; Mon, 28 May 2001 18:29:07 -0400
Date: Tue, 29 May 2001 00:29:00 +0200
From: Kurt Roeckx <Q@ping.be>
To: Vadim Lebedev <vlebedev@aplio.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Potenitial security hole in the kernel
Message-ID: <20010529002900.A3190@ping.be>
In-Reply-To: <003601c0e7bf$41953080$0101a8c0@LAP>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <003601c0e7bf$41953080$0101a8c0@LAP>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2001 at 11:43:38PM +0200, Vadim Lebedev wrote:
> Hi folks,
> 
> Please correct me if i'm wrong but it seems to me that i've stumbled on
> really BIG security hole in the signal handling code.
> The problem IMO is that the signal handling code stores a processor context
> on the user-mode stack frame which is active while

And how is that different from any other function call?


Kurt

