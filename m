Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265069AbTLRKoQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 05:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265071AbTLRKoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 05:44:16 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:44163 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S265069AbTLRKoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 05:44:10 -0500
Date: Thu, 18 Dec 2003 11:43:48 +0100
From: Axel Siebenwirth <axel@pearbough.net>
To: linux-kernel@vger.kernel.org
Subject: Can't bk clone linux-2.5
Message-ID: <20031218104348.GA9007@neon>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: pearbough.net
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm lost. I cannot clone linux-2.5 bk tree.

I am in an empty directory. Then I do:

bk clone http://linux.bkbits.net/linux-2.5 linus-2.5                                                                                
Clone http://linux.bkbits.net/linux-2.5
   -> file://usr/local/src/kernel/linus-2.5
14 bytes uncompressed to 10, 0.71X expansion
Looking for, and removing, any uncommitted deltas...
Set parent to http://linux.bkbits.net/linux-2.5
Running consistency check ...
get: couldn't open SCCS/s.ChangeSet
get: No such file: SCCS/s.ChangeSet
sfiles: can't init ChangeSet: No such file or directory
idcache: No such file or directory
Consistency check failed, repository left locked.
WARNING: deleting orphan file /tmp/bk_clone2_gdZWv7
Exit 1

Whats going on?

Best regards,
Axel


P.S.
bk version
BitKeeper version is bk-3.0.2 20030813204105 for x86-glibc22-linux
Built by: lm@redhat71.bitmover.com in /build/bk-3.0.2-lm/src
Built on: Wed Aug 13 14:11:46 PDT 2003

____________________________________________________________________________
Axel Siebenwirth				      phone +49 3641 776807 |
Am Birnstiel 3			 		  axel at pearbough dot net |
07745 Jena								    |
Germany________________________________________________http://pearbough.net |

Recent research has tended to show that the Abominable No-Man
is being replaced by the Prohibitive Procrastinator.
                -- C.N. Parkinson
____________________________________________________________________________
