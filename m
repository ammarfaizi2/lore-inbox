Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268259AbUIBSSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268259AbUIBSSa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 14:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268250AbUIBSSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 14:18:30 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:58082 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S268227AbUIBSSW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 14:18:22 -0400
Subject: Re: Time runs exactly three times too fast
From: john stultz <johnstul@us.ibm.com>
To: Oliver Hunt <oliverhunt@gmail.com>
Cc: Romain Moyne <aero_climb@yahoo.fr>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4699bb7b04090122465214bcd7@mail.gmail.com>
References: <200409021453.09730.aero_climb@yahoo.fr>
	 <1094069950.14662.208.camel@cog.beaverton.ibm.com>
	 <4699bb7b04090122465214bcd7@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1094149106.14662.306.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 02 Sep 2004 11:18:26 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-01 at 22:46, Oliver Hunt wrote:
> A friend of mine had a similar problem when updating his debian system
> last night, so is this a problem with the current debian patch set?
> 
> Apparently it went away after playing with acpi, so maybe it is the PM
> time source...

I'm not sure, but testing the ACPI PM time source narrows down if it is
a cpu frequency issue or a timer interrupt issue.

thanks
-john

