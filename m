Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270081AbTG1Ojj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 10:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270093AbTG1Ojj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 10:39:39 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:9232 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S270081AbTG1Oji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 10:39:38 -0400
Date: Mon, 28 Jul 2003 16:54:52 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pete Zaitcev <zaitcev@redhat.com>,
       Chris Heath <chris@heathens.co.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i8042 problem
Message-ID: <20030728145452.GA1753@win.tue.nl>
References: <20030728115924.GB1706@win.tue.nl> <Pine.GSO.3.96.1030728155303.15233A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030728155303.15233A-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 04:01:27PM +0200, Maciej W. Rozycki wrote:

> Well, are timeouts needed at all?

Yes. We send a command to the keyboard. It may react, or it may not.


