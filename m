Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751975AbWCKMJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbWCKMJW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 07:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWCKMJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 07:09:22 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:31955 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751975AbWCKMJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 07:09:21 -0500
Date: Sat, 11 Mar 2006 13:09:10 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Arjan van de Ven <arjan@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, garloff@suse.de,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] KERN_SETUID_DUMPABLE in /proc/sys/fs/
In-Reply-To: <1142064294.3055.13.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0603111308450.9603@yvahk01.tjqt.qr>
References: <20060310155738.GL5766@tpkurt.garloff.de>  <20060310145605.08bf2a67.akpm@osdl.org>
  <1142061816.3055.6.camel@laptopd505.fenrus.org>  <20060310234155.685456cd.akpm@osdl.org>
  <1142063254.3055.9.camel@laptopd505.fenrus.org>  <20060310235103.4e9c9457.akpm@osdl.org>
 <1142064294.3055.13.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>the setuid-dumpable sysctl got misplaces due to a patch glitch. But it's
>part of the ABI now for some time so we need to keep it. This patch at
>least renames the variable inside the kernel to match the new place, and
>puts a comment in place to indicate that it's a known glitch
>
"To be corrected to the right thing for 2.7".

