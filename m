Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbUBZM3F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 07:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262780AbUBZM3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 07:29:04 -0500
Received: from 75.80-203-232.nextgentel.com ([80.203.232.75]:4046 "EHLO
	lincoln.jordet.nu") by vger.kernel.org with ESMTP id S262777AbUBZM3C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 07:29:02 -0500
Subject: Re: [RFC] ACPI power-off on P4 HT
From: Stian Jordet <liste@jordet.nu>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <20040226105744.GA3406@alpha.home.local>
References: <1076145024.8687.32.camel@dhcppc4>
	 <20040208082059.GD29363@alpha.home.local>
	 <20040208090854.GE29363@alpha.home.local>
	 <20040214081726.GH29363@alpha.home.local>
	 <1076824106.25344.78.camel@dhcppc4>
	 <20040225070019.GA30971@alpha.home.local>
	 <1077695701.5911.130.camel@dhcppc4> <20040226075609.GA745@uberboxen>
	 <20040226105744.GA3406@alpha.home.local>
Content-Type: text/plain
Message-Id: <1077798440.955.1.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 26 Feb 2004 13:28:49 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tor, 26.02.2004 kl. 11.57 skrev Willy Tarreau:
> OK, could you try this patch ? please note that it's just a test patch, not
> one which should be applied to any tree !
> If it hangs, it may be interesting to know what is the last line displayed.
> Please halt your system out of X11 to see console messages.
> It works for me on the P4 HT 100% of the time now.

Hi Willy,

Do you have a similar patch for 2.6?

Best regards,
Stian

