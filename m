Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276074AbRJBSFA>; Tue, 2 Oct 2001 14:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276081AbRJBSEu>; Tue, 2 Oct 2001 14:04:50 -0400
Received: from web13102.mail.yahoo.com ([216.136.174.147]:24332 "HELO
	web13102.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S276074AbRJBSEe>; Tue, 2 Oct 2001 14:04:34 -0400
Message-ID: <20011002180502.25799.qmail@web13102.mail.yahoo.com>
Date: Tue, 2 Oct 2001 11:05:02 -0700 (PDT)
From: Chris Rankin <rankincj@yahoo.com>
Subject: Which is currently the most stable 2.4 kernel?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have 2 servers which might need to go unattended for
several weeks at a time. They are currently running
vanilla 2.4.10 but my confidence in this (SMP) kernel
has been shaken when it spontaneously froze solid the
other day while I was viewing a web-page in Mozilla.
(And all I was doing was using the scrollbar on an
already-loaded page! No oops messages, no chance to
use Alt-SysRq, nothing.)

All that the servers would be doing would be
connecting to the Internet periodically using PPPoE
and DSL (with NAT), forwarding emails and performing
various CPU-bound tasks. They should both have ample
available memory and should not need to swap much, if
at all.

Does anyone have any kernel recommendations /
counter-recommendations, please? One server is SMP,
the other is UP, and both are Intel architecture.

Cheers,
Chris


__________________________________________________
Do You Yahoo!?
Listen to your Yahoo! Mail messages from any phone.
http://phone.yahoo.com
