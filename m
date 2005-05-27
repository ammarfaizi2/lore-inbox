Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262582AbVE0UoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262582AbVE0UoN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 16:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbVE0UoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 16:44:12 -0400
Received: from web61018.mail.yahoo.com ([209.73.179.12]:35975 "HELO
	web61018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262582AbVE0UmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 16:42:18 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=ILSahWPqdIavmBtSL6NUJQVThcO4w2Fm3WRC1197+bNg8/dyyadUjydrdjKWMcGHccmRUtE2kVDubZzi5dvOWxRwjMGnE3nBPRa9NYZnPTHMAa1PkbJg3HpfU8wJmpqMRsoKlfZpKBF9N/B1A28yYavD2wnnm/rIkX6kXNN9lD8=  ;
Message-ID: <20050527204214.31693.qmail@web61018.mail.yahoo.com>
Date: Fri, 27 May 2005 13:42:14 -0700 (PDT)
From: trusted linux <tcimpl2005@yahoo.com>
Subject: TPM on IBM thinkcenter S51 
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
 
I can't make TPM work on an IBM thinkcenter S51
running 2.6.12-rc5 kernel. Here is what I did:
 
1. build the drivers tpm.ko and tpm_nsc.ko and
modprobe tpm
2. create /dev/tpm
3. build tpm libtcpa (version 1.1)
4. run tcpa_demo 
 
then I got an error "Can't open TPM driver". 
 
I also tried tpm_amtel (though I believe mine is nsc)
and the same error too. 
 
Does anybody experience the same problem and have a
clue? 
 
 
thanks,
 
Gavin, 
 



		
__________________________________ 
Yahoo! Mail Mobile 
Take Yahoo! Mail with you! Check email on your mobile phone. 
http://mobile.yahoo.com/learn/mail 
