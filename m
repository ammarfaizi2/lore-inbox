Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263717AbTEMXIE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 19:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbTEMXIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 19:08:04 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:29991 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S263717AbTEMXID
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 19:08:03 -0400
Subject: Re: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1030513161327.18019D-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1030513161327.18019D-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052865545.1992.15.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 13 May 2003 17:39:06 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-13 at 15:17, Bill Davidsen wrote:

> 2 - if you don't use USB why not just take the driver out?

Because a driver that runs amok, silently causing
interrupt latency problems, becomes a real support
nightmare for others.

> It would be nice to prevent the problem, of course.

Agreed

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


