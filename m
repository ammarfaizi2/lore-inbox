Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbTFJJ26 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 05:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbTFJJ26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 05:28:58 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:24960 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262525AbTFJJ25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 05:28:57 -0400
Date: Tue, 10 Jun 2003 10:49:52 +0100
From: john@grabjohn.com
Message-Id: <200306100949.h5A9nqCd000654@81-2-122-30.bradfords.org.uk>
To: linux-kernel@vger.kernel.org, s.rivoir@gts.it
Subject: Re: IDE performances, 2.4 vs 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Noting that 2.5 is much slower than 2.4 on disk operations (you *touch*
> it when you have not-so-fast machine and use KDE, for example)

I noticed that KDE 3.1.1 was noticably slower to start on 2.5.69 than 2.4.21-rc1
when I briefly tested it on an Athlon XP 2200+ with 512 MB of RAM.

(Unfortunaly I haven't had much time for 2.5 testing, or any testing actually,
for a few months, but I tested it briefly when I first built this machine,
before it went in to production use.  Once all the security issues are addressed
in the 2.5 tree, I intend to start using it on a few production boxes, though).

John.
