Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263108AbTDFVfZ (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 17:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263111AbTDFVfZ (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 17:35:25 -0400
Received: from holomorphy.com ([66.224.33.161]:14492 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263108AbTDFVfY (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 17:35:24 -0400
Date: Sun, 6 Apr 2003 14:46:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Love <rml@tech9.net>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Martin Bligh <mbligh@aracnet.com>
Subject: Re: 2.5.65-preempt booting on 32way NUMAQ
Message-ID: <20030406214631.GP993@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Love <rml@tech9.net>, Zwane Mwaikambo <zwane@linuxpower.ca>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Martin Bligh <mbligh@aracnet.com>
References: <Pine.LNX.4.50.0304060625130.2268-100000@montezuma.mastecende.com> <20030406112340.GM993@holomorphy.com> <1049653846.753.156.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049653846.753.156.camel@localhost>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-04-06 at 07:23, William Lee Irwin III wrote:
>> All that's really left is driver and non-i386 arch coverage if I'm right.

On Sun, Apr 06, 2003 at 02:30:46PM -0400, Robert Love wrote:
> If you know of something specific, please share.  I know the tty layer
> needs work, but as far as I can tell, it is SMP issues that preemption
> exposes... if any drivers in specific need work, let me know.

I presumed the audit was perpetual and/or ongoing.


-- wli
