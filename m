Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264748AbSLBOr6>; Mon, 2 Dec 2002 09:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264749AbSLBOr6>; Mon, 2 Dec 2002 09:47:58 -0500
Received: from linux.kappa.ro ([194.102.255.131]:55428 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S264748AbSLBOr5>;
	Mon, 2 Dec 2002 09:47:57 -0500
Date: Mon, 2 Dec 2002 16:55:24 +0200
From: Teodor Iacob <Teodor.Iacob@astral.kappa.ro>
To: linux-kernel@vger.kernel.org
Subject: [2.4.19] invalidate: busy buffer
Message-ID: <20021202145524.GA30789@linux.kappa.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-RAVMilter-Version: 8.3.0(snapshot 20011220) (linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I have the following setup:

Redhat 8.0 installed on a raid software on 2 identical
40GB Maxtor disks, one partition only as / and I get the
error mentioned in the subject when I do hdparm -Tt /dev/md0
for example, but it also appears when I reboot at the very
end of the init reboot stage.

Teo
