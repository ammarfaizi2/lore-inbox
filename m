Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbVAUE2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbVAUE2t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 23:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbVAUE2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 23:28:49 -0500
Received: from web60606.mail.yahoo.com ([216.109.118.244]:37209 "HELO
	web60606.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262270AbVAUE2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 23:28:47 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=NqBFjPcTN9B7tgyZeKwYNqbizCX/S88DYacN6tqLXvwI0JlGhsyrCflvrW0xPmYu8ot32he9TPqCA39ubHW8BqOvsxxLDH2r0Ow2mlL62aPx4G+iUaep0TKWPAdiDE+rzgSY/G5nWYV0O6U+VI3UJF1rbSa54PvAYVQRl979y7A=  ;
Message-ID: <20050121042846.26605.qmail@web60606.mail.yahoo.com>
Date: Thu, 20 Jan 2005 20:28:46 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: System calls effect after booting phase ?? 
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200412291205.iBTC52RX016345@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Valdis.Kletnieks@vt.edu wrote:

> Possibility 1:
> Load them from an initrd image while booting.  If
> you're already
> using an initrd, and this is "early enough", you
> just need to put the
> module into the initrd, and make sure the /linuxrc
> or whatever script
> does an insmod for it.  This has the advantage of
> working for out-of-tree
> modules.

 Now, I am using an initrd image. How can I load my
module there? In which file, should I insert the
corresponding line? Can u tell me more regarding this
on how to do it? I am using kernel 2.4.28. should I
have to recompile the whole kernel once again? 

Thanks,
selva




		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 

