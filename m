Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264269AbTCXRoT>; Mon, 24 Mar 2003 12:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264305AbTCXRoT>; Mon, 24 Mar 2003 12:44:19 -0500
Received: from calc.cheney.cx ([207.70.165.48]:35467 "EHLO calc.cheney.cx")
	by vger.kernel.org with ESMTP id <S264274AbTCXRoS>;
	Mon, 24 Mar 2003 12:44:18 -0500
Date: Mon, 24 Mar 2003 11:55:26 -0600
From: Chris Cheney <ccheney@cheney.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: KT400 / HPT372 Bug
Message-ID: <20030324175526.GK4004@cheney.cx>
References: <20030322073832.GR13034@cheney.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030322073832.GR13034@cheney.cx>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried a 2.5.65-ac4 kernel and noticed that IOAPIC on the KT400 is
still broken. So I didn't do much testing on HPT372, it does look like
it works now however.  With IOAPIC being broken I can't use the via
rhine nic or onboard VT8235 integrated sound.  IOAPIC with HPT372, via
rhine, and integrated sound all work fine on the 2.4 kernel I am using
2.4.21-pre5-ac3.

Chris
