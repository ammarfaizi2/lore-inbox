Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264923AbUF1MWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264923AbUF1MWP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 08:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264924AbUF1MWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 08:22:15 -0400
Received: from host-212-158-219-180.bulldogdsl.com ([212.158.219.180]:2957
	"EHLO aeryn.fluff.org.uk") by vger.kernel.org with ESMTP
	id S264923AbUF1MWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 08:22:13 -0400
Date: Mon, 28 Jun 2004 13:22:10 +0100
From: Ben Dooks <ben@fluff.org.uk>
To: Deshpande M <pdspartan@yahoo.com>
Cc: Ben Dooks <ben@mail.home.fluff.org>, linux-kernel@vger.kernel.org
Subject: Re: Kernel freezes- Init process in console driver
Message-ID: <20040628122210.GB890@home.fluff.org>
Reply-To: Ben Dooks <ben@fluff.org.uk>
References: <20040628120645.GA890@home.fluff.org> <20040628120950.44302.qmail@web90105.mail.scd.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040628120950.44302.qmail@web90105.mail.scd.yahoo.com>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 05:09:50AM -0700, Deshpande M wrote:
> I tried with 2.6.4 but the result is same. 

2.6.6 (iirc) is the first to carry all the arm modifications
as standard. It is best to try the latest version before asking
questions, just in case the problem has been fixed.

If you are still having problems, check the code producing
the ticks for the system, and check the serial code is working.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
