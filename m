Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266210AbTCDX1R>; Tue, 4 Mar 2003 18:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266932AbTCDX1R>; Tue, 4 Mar 2003 18:27:17 -0500
Received: from FORT-POINT-STATION.MIT.EDU ([18.7.7.76]:9977 "EHLO
	fort-point-station.mit.edu") by vger.kernel.org with ESMTP
	id <S266210AbTCDX0e>; Tue, 4 Mar 2003 18:26:34 -0500
To: linux-kernel@vger.kernel.org
Subject: ipsec-tools package at sourceforge
From: Derek Atkins <warlord@MIT.EDU>
Date: 04 Mar 2003 18:37:03 -0500
Message-ID: <sjmadgaya8w.fsf@kikki.mit.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've uploaded a new version of ipsec-tools to sourceforge.
IPsec-Tools is a port of KAME's "libipsec", "setkey", and "racoon"
programs to Linux.  The setkey program lets you set IPsec policy and
manually manipulate IPsec SAs; racoon is an Internet Key Exchange
(IKE) keying daemon for automatically negotiating IPsec SAs with
peers.

These tools have been updated from the version in Alexey's ip-utils
snapshot (which was using year-old KAME code).

You can find the source tarball at the Sourceforge project page:

        http://ipsec-tools.sourceforge.net/

Testers are certainly encouraged.

Thanks,

-derek

-- 
       Derek Atkins, SB '93 MIT EE, SM '95 MIT Media Laboratory
       Member, MIT Student Information Processing Board  (SIPB)
       URL: http://web.mit.edu/warlord/    PP-ASEL-IA     N1NWH
       warlord@MIT.EDU                        PGP key available
