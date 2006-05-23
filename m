Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWEWOP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWEWOP3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 10:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWEWOP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 10:15:29 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:395 "EHLO
	out3.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932096AbWEWOP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 10:15:28 -0400
Message-Id: <1148393727.14381.262121289@webmail.messagingengine.com>
X-Sasl-Enc: noLy0q9XNLalGWAIZTqQbBOltX/3cHDWzf9OACua9jbx 1148393727
From: "Ivan Novick" <ivan@0x4849.net>
To: "Nuri Jawad" <lkml@jawad.org>,
       "Alistair John Strachan" <s0348365@sms.ed.ac.uk>
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       julian@valgrind.org
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MIME::Lite 5022  (F2.72; T1.15; A1.62; B3.04; Q3.03)
References: <Pine.LNX.4.64.0605211028100.4037@p34>
   <200605222015.01980.s0348365@sms.ed.ac.uk>
   <Pine.LNX.4.61.0605222220190.6816@yvahk01.tjqt.qr>
   <200605222200.18351.s0348365@sms.ed.ac.uk>
   <Pine.LNX.4.64.0605230407320.25860@pc>
Subject: Re: Linux Kernel Source Compression
In-Reply-To: <Pine.LNX.4.64.0605230407320.25860@pc>
Date: Tue, 23 May 2006 15:15:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cc'ing Julian Seward the author of bzip2

----- Original message -----
Hi,
just wanted to remark that I never liked that bzip was replaced by bzip2 
(were there license issues?) since bzip's compression was/is often 
stronger:

39843104 Mar 28 09:33 linux-2.6.15.7.tar.bz2
39423739 Mar 28 09:33 linux-2.6.15.7.tar.bz

Not a big difference in this case but still a step back. I for once am 
keeping my bzip binary.. does anyone know where the source can still be 
found?
