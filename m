Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbTE0VoF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 17:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264200AbTE0VoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 17:44:04 -0400
Received: from franka.aracnet.com ([216.99.193.44]:43220 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264192AbTE0Vnh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 17:43:37 -0400
Date: Tue, 27 May 2003 14:56:04 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: John Stoffel <stoffel@lucent.com>,
       William Lee Irwin III <wli@holomorphy.com>
cc: DevilKin-LKML <devilkin-lkml@blindguardian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.70 compile error
Message-ID: <3440000.1054072563@[10.10.2.4]>
In-Reply-To: <16083.42349.964658.11555@gargle.gargle.HOWL>
References: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com><200305271048.36495.devilkin-lkml@blindguardian.org><20030527130515.GH8978@holomorphy.com><200305271729.49047.devilkin-lkml@blindguardian.org><20030527153619.GJ8978@holomorphy.com><16083.35048.737099.575241@gargle.gargle.HOWL><20030527155259.GK8978@holomorphy.com><16083.37850.528654.94908@gargle.gargle.HOWL><20030527164300.GL8978@holomorphy.com> <16083.42349.964658.11555@gargle.gargle.HOWL>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The language and description used when running 'make oldconfig' and
> trying to set the "X86_GENERICARCH" option is ugly and hard to
> understand and doesn't match how it's shown in the 'make menuconfig'
> settings.  

Generic arch will take over half of the other arches when it's a bit 
better tested. Generic PC is, I believe, the default - if that's not
working, let us know. Otherwise, don't mess with the defaults if you
don't understand the question ;-)

M.

