Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268006AbUHFOHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268006AbUHFOHZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 10:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268017AbUHFOHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 10:07:25 -0400
Received: from holomorphy.com ([207.189.100.168]:24012 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268006AbUHFOHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 10:07:22 -0400
Date: Fri, 6 Aug 2004 07:07:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Albert Cahalan <albert@users.sf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: [proc.txt] Fix /proc/pid/statm documentation
Message-ID: <20040806140714.GG17188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Roger Luethi <rl@hellgate.ch>, Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org
References: <1091754711.1231.2388.camel@cube> <20040806094037.GB11358@k3.hellgate.ch> <20040806104630.GA17188@holomorphy.com> <20040806120123.GA23081@k3.hellgate.ch> <20040806121118.GE17188@holomorphy.com> <20040806135756.GA21411@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806135756.GA21411@k3.hellgate.ch>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Aug 2004 05:11:18 -0700, William Lee Irwin III wrote:
>> Some of the 2.4 semantics just don't make sense. I would not find it
>> difficult to explain what I believe correct semantics to be in a written
>> document.

On Fri, Aug 06, 2004 at 03:57:56PM +0200, Roger Luethi wrote:
> IMO this is a must for such files (and be it only some comments above
> the code implementing them). I'm afraid that statm is carrying too much
> historical baggage, though -- you would add yet another interpretation
> of those 7 fields.
> Tools reading statm would have to be updated anyway, so I'd rather
> think about what could be done with a new (or just different) file.

Okay, could you write up a "specification" for what you want reported,
then I can cook up a new file or some such for you?

Thanks.


-- wli
