Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268339AbTBSKGB>; Wed, 19 Feb 2003 05:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268340AbTBSKGA>; Wed, 19 Feb 2003 05:06:00 -0500
Received: from mail.uptime.at ([62.116.87.11]:17327 "EHLO mail.uptime.at")
	by vger.kernel.org with ESMTP id <S268339AbTBSKF7> convert rfc822-to-8bit;
	Wed, 19 Feb 2003 05:05:59 -0500
Received-Date: Wed, 19 Feb 2003 11:14:38 +0100
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: "=?iso-8859-1?Q?'M=E5ns_Rullg=E5rd'?=" <mru@users.sourceforge.net>
Cc: <axp-kernel-list@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Module problems (WAS: RE: 2.5.62 on Alpha SUCCESS (2.6 release soon!?))
Date: Wed, 19 Feb 2003 11:14:13 +0100
Organization: UPtime system solutions
Message-ID: <008001c2d7ff$aa12b420$020b10ac@pitzeier.priv.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <yw1xof59202j.fsf@bamse.e.kth.se>
Importance: Normal
X-MailScanner: clean
X-MailScanner-Information: Please contact UPtime Systemloesungen for more information
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.2, required 5.3,
	AWL, IN_REP_TO, NOSPAM_INC, PLING_QUERY, SPAM_PHRASE_00_01)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:
> "Oliver Pitzeier" <o.pitzeier@uptime.at> writes:
[ ... ]
> > OK... Make modules_install still has problems:
[ ... ]
> Which versions of binutils and gcc do you have?  I get 
> similar problems with binutils 2.13 and 2.4 kernels.

This is my current env.:
[root@track /root]# rpm -q modutils binutils gcc
modutils-2.4.22-8
binutils-2.12.90.0.7-3
gcc-3.1-6

Maybe I should upgrade gcc? But I believe 3.1 is working fine... At least for my
normally...

Best regards,
 Oliver


