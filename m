Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbTK1Wtl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 17:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263545AbTK1Wtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 17:49:40 -0500
Received: from holomorphy.com ([199.26.172.102]:13508 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263544AbTK1Wtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 17:49:39 -0500
Date: Fri, 28 Nov 2003 14:49:28 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Misha Nasledov <misha@nasledov.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: APM Suspend Problem
Message-ID: <20031128224928.GD8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nigel Cunningham <ncunningham@clear.net.nz>,
	Misha Nasledov <misha@nasledov.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20031127062057.GA31974@nasledov.com> <20031128212853.GB8039@holomorphy.com> <20031128215008.GA2541@nasledov.com> <20031128215031.GC8039@holomorphy.com> <1070058437.2380.43.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070058437.2380.43.camel@laptop-linux>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 29, 2003 at 11:27:17AM +1300, Nigel Cunningham wrote:
> Dunno if I'm an expert, but I might be able to help. None of the Linux
> based suspends (2.4 or 2.6) will get started unless something like acpid
> pushes them. If a laptop suspends without running acpid or similar, it
> must be doing it from the BIOS.

apmd is running, though I don't know if it's the one doing it.

It also seems to be dependent on CONFIG_APM.


-- wli
