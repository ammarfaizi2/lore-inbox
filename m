Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263531AbTJaTuJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 14:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263533AbTJaTuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 14:50:09 -0500
Received: from palrel11.hp.com ([156.153.255.246]:23703 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S263531AbTJaTuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 14:50:06 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16290.48361.970446.61879@napali.hpl.hp.com>
Date: Fri, 31 Oct 2003 11:50:01 -0800
To: David Brownell <david-b@pacbell.net>
Cc: davidm@hpl.hp.com, Greg KH <greg@kroah.com>, vojtech@suse.cz,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
In-Reply-To: <3FA2B7D4.5010707@pacbell.net>
References: <200310272235.h9RMZ9x1000602@napali.hpl.hp.com>
	<20031028013013.GA3991@kroah.com>
	<200310280300.h9S30Hkw003073@napali.hpl.hp.com>
	<3FA12A2E.4090308@pacbell.net>
	<16289.29015.81760.774530@napali.hpl.hp.com>
	<16289.55171.278494.17172@napali.hpl.hp.com>
	<3FA28C9A.5010608@pacbell.net>
	<16290.43822.444275.360988@napali.hpl.hp.com>
	<3FA2B7D4.5010707@pacbell.net>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 31 Oct 2003 11:28:20 -0800, David Brownell <david-b@pacbell.net> said:

  David.B> You sound alarmed!  If that's alarmed enough to find out
  David.B> what the real problem is, maybe you'll end up fixing it
  David.B> ... :)

Except I know almost nothing about the USB stack.

  David.B> Agreed, oopsing == bad.  HID needs more attention.  I
  David.B> suspect whoever dives into that will want to know what you
  David.B> mean by "(mostly) fine"; that might give a clue about what
  David.B> 2.6 changes worsened the failures.

Are you saying nobody is maintaining HID?

	--david
