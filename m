Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272038AbTG2UIZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 16:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272042AbTG2UIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 16:08:24 -0400
Received: from hockin.org ([66.35.79.110]:41733 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S272038AbTG2UIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 16:08:20 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200307291951.h6TJptv06159@www.hockin.org>
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
To: john@grabjohn.com (John Bradford)
Date: Tue, 29 Jul 2003 12:51:54 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org, pgw99@doc.ic.ac.uk
In-Reply-To: <200307291915.h6TJF6YB000421@81-2-122-30.bradfords.org.uk> from "John Bradford" at Jul 29, 2003 08:15:06 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I haven't had chance to test this yet, but I really like the idea - by
> an amasing co-incidence, I was actually thinking about the possibility
> of doing a parallel port connected front panel earlier today!
> 
> Does anybody have any suggestions for recommended standard uses for
> parallel port connected LEDs?
> 
> Disk spinning up/disk ready
> Root login active

In the cobalt days we had a parallel port connected panel with an LCD (2
lines x 16 characters) 6 buttons (up, down, left, right, select, enter) and
LEDs (Disk, network activity, network link, 100 MB status, and web activity
[required a hacked apache, but it was cute]).

Our RaQXTR boxes had even more - and they were all software programmable.
