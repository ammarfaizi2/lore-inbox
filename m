Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267619AbTBFUW5>; Thu, 6 Feb 2003 15:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267624AbTBFUW5>; Thu, 6 Feb 2003 15:22:57 -0500
Received: from franka.aracnet.com ([216.99.193.44]:62177 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267619AbTBFUW4>; Thu, 6 Feb 2003 15:22:56 -0500
Date: Thu, 06 Feb 2003 12:32:29 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bugme-new] [Bug 304] New: TCP sessions hang when connecting Solaris 2.6
Message-ID: <262950000.1044563549@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=304

           Summary: TCP sessions hang when connecting Solaris 2.6
    Kernel Version: 2.5.59
            Status: NEW
          Severity: high
             Owner: davem@vger.kernel.org
         Submitter: tedkaz@optonline.net


Distribution:Redhat Phoebe
Hardware Environment: No Modules, 3c59x built into kernel, P4 1,7gig
Software Environment: xterm, gnome-terminal
Problem Description: TCP sessions hand when connecting to Solaris 2.6

Steps to reproduce: Open up either ssh or rlogin into Solaris 2.6. Any action
which causes moderate packet rates will hang the session. The box in question
is behind a firewall with a cipe tunnel back to the DA. I will upload ethereal
data capture of failed session. Hope this is helpful.


