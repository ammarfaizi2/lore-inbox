Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVALIxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVALIxu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 03:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVALIxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 03:53:50 -0500
Received: from web60607.mail.yahoo.com ([216.109.118.245]:21070 "HELO
	web60607.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261300AbVALIxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 03:53:46 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=XWbDHQBD7Azht/u0TUIgp5sDk0mC3lp16QWucHTR66JHuvowrXaNPMyJkxfaQEDXMlFXfzGW+5nhmYKyF9FjjrZ1WutElvOI6Ml6bC0wMH2hSif3KMIyPfo8Co3SDZGHMWvXFdrSM/cX/zxE35IS+XqV/Hb3IshXRSRLUjxyDQM=  ;
Message-ID: <20050112085345.88349.qmail@web60607.mail.yahoo.com>
Date: Wed, 12 Jan 2005 00:53:45 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Removing a module even if use count is not zero
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello linux-experts,
    I inserted my module into the running kernel that
intercepts read system call. I am using kernel 2.4.28.
Now, I am unable to remove it since each and every
time, the module is used by some process. How can I
remove the module even if the usecount is not zero?
    Can anyone help me regarding this?

Thanks,
selva


		
__________________________________ 
Do you Yahoo!? 
Take Yahoo! Mail with you! Get it on your mobile phone. 
http://mobile.yahoo.com/maildemo 
