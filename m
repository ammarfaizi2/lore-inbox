Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268819AbUH3Tba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268819AbUH3Tba (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 15:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268404AbUH3TbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 15:31:23 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:24477 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S268275AbUH3T13 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 15:27:29 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] Oops and panic while unloading holder of pm_idle
Date: Mon, 30 Aug 2004 13:09:53 +0200
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       len.brown@intel.com
References: <200408171728.06262.blaisorblade_spam@yahoo.it> <Pine.LNX.4.58.0408231839280.13924@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0408231839280.13924@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200408301309.54465.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 00:41, martedì 24 agosto 2004, Zwane Mwaikambo ha scritto:
> On Thu, 19 Aug 2004, BlaisorBlade wrote:
> > (CC me on replies as I'm not subscribed).
> >
> > A short description, with my hypothesis about how the panic() happened:
>
> There is a short one liner for this which is already in the latest
> kernel;

Ok, fine, that's a lot better than my fix - and what about the stacking 
problem? Also there are some other drivers which could need fixing, probably 
(I've not the time now).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

