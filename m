Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265117AbTLKPSe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 10:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265119AbTLKPSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 10:18:33 -0500
Received: from holomorphy.com ([199.26.172.102]:60645 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265117AbTLKPRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 10:17:18 -0500
Date: Thu, 11 Dec 2003 07:17:09 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rhino <rhino9@terra.com.br>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: Re: [CFT][RFC] HT scheduler
Message-ID: <20031211151709.GG8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rhino <rhino9@terra.com.br>, Nick Piggin <piggin@cyberone.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	Mark Wong <markw@osdl.org>
References: <3FD3FD52.7020001@cyberone.com.au> <20031208155904.GF19412@krispykreme> <3FD50456.3050003@cyberone.com.au> <20031209001412.GG19412@krispykreme> <3FD7F1B9.5080100@cyberone.com.au> <3FD81BA4.8070602@cyberone.com.au> <20031211060120.4769a0e8.rhino9@terra.com.br> <20031211114018.GB8039@holomorphy.com> <20031211130536.34e5202f.rhino9@terra.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031211130536.34e5202f.rhino9@terra.com.br>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Dec 2003 03:40:18 -0800 William Lee Irwin III <wli@holomorphy.com> wrote:
>> It might help to check how many processes and/or threads are involved.
>> I've got process scalability stuff in there (I'm not sure how to read
>> your comments though they seem encouraging).

On Thu, Dec 11, 2003 at 01:05:36PM -0400, Rhino wrote:
> heh, they were supposed to .it really looks good. 
> if you provide me a test path to address your changes,
> i'll happily put it on.

I don't have anything to swap or reclaim the relevant data structures
yet, which is probably what you'll need.


-- wli
