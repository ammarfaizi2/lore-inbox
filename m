Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbULEX3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbULEX3z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 18:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbULEX3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 18:29:55 -0500
Received: from got80-74-137-2.ch-meta.net ([80.74.137.2]:1956 "EHLO
	gothicus.metanet.ch") by vger.kernel.org with ESMTP id S261417AbULEX3w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 18:29:52 -0500
From: Thomas Bettler <bettlert@student.ethz.ch>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: cpufreq: shouldn't scaling_min_freq be lower?
Date: Mon, 6 Dec 2004 00:29:49 +0100
User-Agent: KMail/1.7.1
References: <200412052306.07460.bettlert@student.ethz.ch> <E1Cb5lT-0007vk-00@chiark.greenend.org.uk>
In-Reply-To: <E1Cb5lT-0007vk-00@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412060029.49366.bettlert@student.ethz.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nachricht vom Montag 06 Dezember 2004 00:26:
> Thomas Bettler <bettlert@student.ethz.ch> wrote:
> > In the beginning there was a Windoze on it. The cpufreq varied from 1800
> > to 120MHz
>
> Windows tends to use a combination of CPU scaling and throttling to get
> the processor that slow. Take a look at
> /proc/acpi/processor/*/throttling

Is there a throttle daemon for Linux? It would be great to use this.
