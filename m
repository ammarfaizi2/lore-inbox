Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVFHT2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVFHT2n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 15:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVFHT2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 15:28:43 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:59538 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261562AbVFHT2g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 15:28:36 -0400
Date: Wed, 8 Jun 2005 12:28:53 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Chris Friesen <cfriesen@nortel.com>
Cc: linux-kernel@vger.kernel.org, bhuey@lnxw.com, andrea@suse.de,
       tglx@linutronix.de, karim@opersys.com, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050608192853.GE1295@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050608022646.GA3158@us.ibm.com> <42A73D15.6080201@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A73D15.6080201@nortel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 12:46:45PM -0600, Chris Friesen wrote:
> Paul E. McKenney wrote:
> 
> Nice writeup.

Glad you liked it!

> I think you mixed up the "weaknesses" section between "nested OS" and 
> "dual-os/dual-core".

Good catch!  I have moved the sentence:

	The pair of cores will be more expensive than a single core,
	though one might use virtualization to emulate the two CPUs.

from "nested OS" to "dual-os/dual-core".

							Thanx, Paul
