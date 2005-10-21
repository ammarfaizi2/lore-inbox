Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbVJUHp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbVJUHp3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 03:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbVJUHp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 03:45:29 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:47010 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964898AbVJUHp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 03:45:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:User-Agent;
  b=j4bBigZ1Z7RcEcMtKDGC/0cWphV2fsWzmn35BWHRAV2j4044aDkA346FEQ7hB6qzDiRvT1r2gme4kc8q24OfwdXr4gJVd5HKuRcBJm/67PEQjp5/iBgs4xtJGy9j/8ZiVp3QeBuT2HE+3awcBIrte34mL1AKhv7I9yegjWKC3pg=  ;
Date: Fri, 21 Oct 2005 09:45:25 +0200
From: Borislav Petkov <bbpetkov@yahoo.de>
To: dbrownell@users.sourceforge.net
Cc: greg@kroah.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [rc4-mm1] usb-handoff doesn't fix bug #5428
Message-ID: <20051021074525.GA28959@gollum.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi David,

 I'm booting rc4-mm1 for the 3rd time this morning and it hangs at the
 same point as before. (see: http://bugzilla.kernel.org/show_bug.cgi?id=5428)
 I'm only using the 'usb-handoff' boot option
 without your patch that halts the ehci controller early in the boot
 process as you said but this approach doesn't seem to fix it. Suggestions?

 Regards,
	 Boris.

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
