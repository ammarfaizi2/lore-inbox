Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965012AbVJUQOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbVJUQOW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 12:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbVJUQOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 12:14:22 -0400
Received: from mx1.suse.de ([195.135.220.2]:29417 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965012AbVJUQOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 12:14:22 -0400
From: Andreas Schwab <schwab@suse.de>
To: "Vincent W. Freeh" <vin@csc.ncsu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Understanding Linux addr space, malloc, and heap
References: <4358F0E3.6050405@csc.ncsu.edu>
	<1129903396.2786.19.camel@laptopd505.fenrus.org>
	<4359051C.2070401@csc.ncsu.edu>
	<1129908179.2786.23.camel@laptopd505.fenrus.org>
	<43590B23.2090101@csc.ncsu.edu>
X-Yow: In order to make PLANS for the WEEKEND...so that we can read RESTAURANT
 REVIEWS and decide to GO to that restaurant & then NEVER GO...so we can
 meet a FRIEND after work in a BAR and COMPLAIN about Interior Sect'y
 JAMES WATT until the SUBJECT is changed to NUCLEAR BLACKMAIL...and so
 our RELATIVES can FORCE us to listen to HOCKEY STATISTICS while we
 wait for them to LEAVE on the 7:48....
Date: Fri, 21 Oct 2005 18:14:18 +0200
In-Reply-To: <43590B23.2090101@csc.ncsu.edu> (Vincent W. Freeh's message of
	"Fri, 21 Oct 2005 11:37:07 -0400")
Message-ID: <je64rqlued.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Vincent W. Freeh" <vin@csc.ncsu.edu> writes:

> The point of the code is to show that one can protect malloc code.

You "can" do many things.  But that does not mean that you always get any
sensible behaviour.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
