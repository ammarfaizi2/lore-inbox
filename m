Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129093AbRBNF4r>; Wed, 14 Feb 2001 00:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129115AbRBNF4h>; Wed, 14 Feb 2001 00:56:37 -0500
Received: from net-1-11.campuscommonsapts.com ([216.64.132.11]:16142 "EHLO
	ghettobox.dhs.org") by vger.kernel.org with ESMTP
	id <S129093AbRBNF4X>; Wed, 14 Feb 2001 00:56:23 -0500
Date: Tue, 13 Feb 2001 21:57:49 -0800 (PST)
From: TeknoDragon <andross@ghettobox.dhs.org>
To: <linux-kernel@vger.kernel.org>
Subject: Destination Loose UDP in 2.4 (net/ipv4/netfilter)
Message-ID: <Pine.LNX.4.32.0102132146560.7508-100000@ghettobox.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What is the status of "dloose udp" in 2.4.x? From my reading in a few list
archives it seems to have been some sort of a hack, yet it is needed for
games such as Asheron's Call to be played behind a firewall.

In 2.2.18 the code implementing this seems to be in net/ipv4/ip_masq.c
and was controlled by a sysctl "ip_masq_udp_dloose".

Is there anything in 2.4.x to replace this functionallity? Is there a way
to replace it with an iptables rule? Any help would be much appreciated.


-karl

