Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbUB0G4D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 01:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbUB0G4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 01:56:03 -0500
Received: from gate.crashing.org ([63.228.1.57]:16314 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261729AbUB0G4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 01:56:02 -0500
Subject: Re: Why no interrupt priorities?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Frank <mhf@linuxmail.org>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       Mark Gross <mgross@linux.co.intel.com>, arjanv@redhat.com,
       Tim Bird <tim.bird@am.sony.com>, root@chaos.analogic.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <opr30muhyf4evsfm@smtp.pacific.net.th>
References: <F760B14C9561B941B89469F59BA3A84702C932F2@orsmsx401.jf.intel.com>
	 <1077859968.22213.163.camel@gaston>  <opr30muhyf4evsfm@smtp.pacific.net.th>
Content-Type: text/plain
Message-Id: <1077864372.22215.193.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 17:46:13 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Never occured to me to use shared IRQ's edge triggered as this mode
> _cannot_ work reliably for HW limitations.

You are right, I wouldn't expect them to be shared indeed..

Ben.


