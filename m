Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264555AbSIRE2v>; Wed, 18 Sep 2002 00:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264560AbSIRE2v>; Wed, 18 Sep 2002 00:28:51 -0400
Received: from holomorphy.com ([66.224.33.161]:65511 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264555AbSIRE2v>;
	Wed, 18 Sep 2002 00:28:51 -0400
Date: Tue, 17 Sep 2002 21:29:33 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Guillaume Boissiere <boissiere@adiglobal.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  September 18, 2002
Message-ID: <20020918042933.GR3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Guillaume Boissiere <boissiere@adiglobal.com>,
	linux-kernel@vger.kernel.org
References: <3D87C1C6.21599.33750A21@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D87C1C6.21599.33750A21@localhost>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2002 at 11:59:02PM -0400, Guillaume Boissiere wrote:
> o Alpha       VM large page support                           (Simon Winwood, Hubertus Franke)

I've been working with Hubertus Franke on a patch based on Simon
Winwood's original MPSS code with some design influence from Shimizu's
code. Shimizu Naohiko has also been involved in the effort, primarily
2.4.x-based patches. Also, Ingo Molnar (and possibly other redhat.com
contributors) deserve priority as theirs was the first patch to provide
such functionality. Rohit Seth has also provided some large page
functionality already included in 2.5.x mainline.

Others may yet become involved.


Thanks,
Bill
