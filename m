Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130779AbRCJArl>; Fri, 9 Mar 2001 19:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130784AbRCJArb>; Fri, 9 Mar 2001 19:47:31 -0500
Received: from attila.bofh.it ([213.92.8.2]:36300 "HELO attila.bofh.it")
	by vger.kernel.org with SMTP id <S130779AbRCJArV>;
	Fri, 9 Mar 2001 19:47:21 -0500
Date: Sat, 10 Mar 2001 00:45:56 +0100
From: "Marco d'Itri" <md@Linux.IT>
To: linux-kernel@vger.kernel.org
Subject: peer shrinks window
Message-ID: <20010310004556.A7380@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In two days I've got 46 messages like:

Mar  7 08:00:55 attila kernel: TCP: peer 163.162.41.4:37582/20 shrinks window 752789960:5840:752797200. Bad, what else can I say?

If needed I can ask about the os running there, I think it's solaris.
(nmap confirms: Solaris 7)

Linux attila 2.4.0-test11 #11 Wed Dec 13 12:02:51 CET 2000 ppc unknown

-- 
ciao,
Marco
