Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751868AbWFTX5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbWFTX5W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 19:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbWFTX5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 19:57:22 -0400
Received: from barracuda.s2io.com ([72.1.205.138]:9351 "EHLO
	barracuda.mail.s2io.com") by vger.kernel.org with ESMTP
	id S1751867AbWFTX5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 19:57:20 -0400
X-ASG-Debug-ID: 1150847837-10709-22-0
X-Barracuda-URL: http://72.1.205.138:8000/cgi-bin/mark.cgi
X-ASG-Whitelist: Client
Reply-To: <ravinandan.arakali@neterion.com>
From: "Ravinandan Arakali" <ravinandan.arakali@neterion.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <tglx@linutronix.de>, <dgc@sgi.com>, <mingo@elte.hu>, <neilb@suse.de>,
       <jblunck@suse.de>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
       <balbir@in.ibm.com>, <ananda.raju@neterion.com>,
       <leonid.grossman@neterion.com>, <jes@trained-monkey.org>
X-ASG-Orig-Subj: RE: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries list (2nd version)
Subject: RE: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries list (2nd version)
Date: Tue, 20 Jun 2006 16:56:54 -0700
Message-ID: <007601c694c5$359c4620$3e10100a@pc.s2io.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20060620151019.797f120c.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=3.5 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
The formal submission will take some more time.
To boot your system, can you use the driver available on our website ? This
has the fix you are looking for. URL is
http://www.neterion.com/support/xframe_customers.html

Ravi

-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org]
Sent: Tuesday, June 20, 2006 3:10 PM
To: ravinandan.arakali@neterion.com
Cc: tglx@linutronix.de; dgc@sgi.com; mingo@elte.hu; neilb@suse.de;
jblunck@suse.de; linux-kernel@vger.kernel.org;
linux-fsdevel@vger.kernel.org; viro@zeniv.linux.org.uk;
balbir@in.ibm.com; ananda.raju@neterion.com;
leonid.grossman@neterion.com; jes@trained-monkey.org
Subject: Re: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries
list (2nd version)


"Ravinandan Arakali" <ravinandan.arakali@neterion.com> wrote:
>
> Do you want the patch to be submitted to netdev(the mailing list that we
> usually submit to) ?

If the patches are a formal submission then please send them to Jeff,
netdev and I'd like a cc too.

If they are not considered quite ready for submission then please just send
them to myself, thanks.  A netdev cc would be appropriate as well.
Basically
I just want to get that sn2 machine to boot.

Generally it's better to cc too many mailing lists and individuals than too
few.

