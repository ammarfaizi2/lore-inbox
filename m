Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265410AbTIJSFQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 14:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265435AbTIJSFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 14:05:16 -0400
Received: from web12301.mail.yahoo.com ([216.136.173.99]:64177 "HELO
	web12301.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265410AbTIJSFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 14:05:08 -0400
Message-ID: <20030910180507.53891.qmail@web12301.mail.yahoo.com>
Date: Wed, 10 Sep 2003 11:05:07 -0700 (PDT)
From: Ravi Krishnamurthy <kravi26@yahoo.com>
Subject: Equivalent of 'insmod -m' on 2.6?
To: linux-kernel@vger.kernel.org
Cc: rusty@rustcorp.com.au
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to debug a module on 2.6.0-test3 with
module-init-tools-0.9.12. But I am not able to get
the load map of the module being loaded. 'insmod'
in module-init-tools does not support the '-m' option. 
While working on 2.4, the load map given by 'insmod -m'
was very useful for debugging modules. Is there an
equivalent for 2.5/2.6 kernels?
Even the new 'struct module' does not seem to contain
all the section and relocation information. 

Please CC me on the replies since I am not subscribed
to the list.

Thanks in advance for any help.

-Ravi.


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
