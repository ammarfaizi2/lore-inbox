Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130457AbRCIOH2>; Fri, 9 Mar 2001 09:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130510AbRCIOHS>; Fri, 9 Mar 2001 09:07:18 -0500
Received: from [208.204.44.103] ([208.204.44.103]:14351 "EHLO
	warpcore.provalue.net") by vger.kernel.org with ESMTP
	id <S130457AbRCIOHD>; Fri, 9 Mar 2001 09:07:03 -0500
Date: Fri, 9 Mar 2001 07:15:16 -0600 (CST)
From: Collectively Unconscious <swarm@warpcore.provalue.net>
To: linux-kernel@vger.kernel.org
Subject: Reboot fails 2.2.19pre11 SMP
In-Reply-To: <20010308160758.A16296@kroah.com>
Message-ID: <Pine.LNX.4.10.10103090553390.18247-100000@warpcore.provalue.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using a server works le bios and kernel 2.2.19pre11 SMP
we get the following message at the end of any reboot attempt (including
the magic alt-sysrq-b):

Disabling symmetric IO mode ... ... done

and then the system freezes requiring a manual reset.

Since we are looking at 100 of these to expand our cluster, it is a non
trivial annoyance, any help would be appreciated.

Jay

