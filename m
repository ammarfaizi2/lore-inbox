Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262378AbVADXhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbVADXhO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 18:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbVADXgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 18:36:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3208 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262378AbVADXTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 18:19:55 -0500
Date: Tue, 4 Jan 2005 18:18:42 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Felipe Alfaro Solana <lkml@mac.com>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@debian.org>
Subject: Re: starting with 2.7
In-Reply-To: <6D2E0FC1-5EA5-11D9-A816-000D9352858E@mac.com>
Message-ID: <Pine.LNX.4.61.0501041817260.19373@chimarrao.boston.redhat.com>
References: <200501042058.j04KwFED002211@laptop11.inf.utfsm.cl>
 <6D2E0FC1-5EA5-11D9-A816-000D9352858E@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2005, Felipe Alfaro Solana wrote:

> Stabilizing, for me at least, means fixing bugs, not adding new features 
> (unless those new features are totally necessary).

The definition of "totally necessary" is going to vary
from user to user.  For some people, the ability to
use AGP on a system with more than 4GB RAM is necessary,
leading to the recent API change.

> Thus, I don't see how freezing the 2.6 codebase, waiting some time for 
> bugs to get fixed and things to settle down, then forking off 2.7 could 
> be a non-sense.

Hey, that's what we do between 2.6.N and 2.6.(N+1) ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
