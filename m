Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263391AbRFAPNQ>; Fri, 1 Jun 2001 11:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263292AbRFAPNG>; Fri, 1 Jun 2001 11:13:06 -0400
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:36487 "EHLO
	mta01-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S263289AbRFAPMq>; Fri, 1 Jun 2001 11:12:46 -0400
Date: Fri, 1 Jun 2001 16:12:26 +0100
From: David Harris <linux@davidharris.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Kernel oops
Message-ID: <20010601161226.A18246@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running gnome netleds_applet version 0.9.1 and it is sporadically
dieing, with a various kernel oops warnings in my syslogs. I caught
the last one and ran it through ksymoops - I've attached the output of
that. It happens every few days and doesn't seem to be caused by
anything specific that I can see. Always the same program, and the
overall stability of the system seems unaffected. If it makes any
difference I have two copies of netleds running (they monitor eth0
and ppp0 separately). The processor is a Cyric 6x86MX233. Any other
information you'd find useful, please contact me!

yours

David Harris

-- 
     David Harris, 10 Carlton Way,     |  My name is Inigo Montoya.
  Cambridge CB4 2BZ Tel: 01223 524413  |    You killed my father.
  Mob: 07977 226941 Fax: 07970 091596  |       Prepare to die.
    http://www.srcf.ucam.org/~djh59/   |
