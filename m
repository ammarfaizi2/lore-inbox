Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269020AbTGJH5J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 03:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269029AbTGJH5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 03:57:09 -0400
Received: from heron.mail.pas.earthlink.net ([207.217.120.189]:51661 "EHLO
	heron.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S269020AbTGJH5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 03:57:07 -0400
Subject: hptraid.o -- No array found?
From: Seth Chromick <seth.chromick@earthlink.net>
Reply-To: seth.chromick@earthlink.net
To: linux-kernel@vger.kernel.org
In-Reply-To: <20030710075927.GS15452@holomorphy.com>
References: <20030708223548.791247f5.akpm@osdl.org>
	 <200307091106.00781.schlicht@uni-mannheim.de>
	 <20030709021849.31eb3aec.akpm@osdl.org>
	 <1057815890.22772.19.camel@www.piet.net>
	 <20030710060841.GQ15452@holomorphy.com>
	 <20030710071035.GR15452@holomorphy.com>
	 <20030710001853.5a3597b7.akpm@osdl.org>
	 <20030710075927.GS15452@holomorphy.com>
Content-Type: text/plain
Organization: 
Message-Id: <1057810183.12513.5.camel@pasture.gentoo.box>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 10 Jul 2003 04:09:43 +0000
Content-Transfer-Encoding: 7bit
X-ELNK-Trace: 21a0d54c758d331d92281a4146f572e474bf435c0eb9d478c4982ace75b7ffb2d9681c9ed788957a62a1ac6668a84b10350badd9bab72f9c350badd9bab72f9c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have XP and Gentoo linux installed. In XP, my IDE RAID0 config can be
seen and used flawlessly (highpoint). In linux, modprobe ataraid works
fine, but modprobing hptraid gives me "Raid array not found" a few times
and stops. Any ideas? I've googled around to no avail...

