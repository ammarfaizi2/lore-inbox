Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVCWOVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVCWOVy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 09:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVCWOVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 09:21:54 -0500
Received: from main.gmane.org ([80.91.229.2]:8155 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261612AbVCWOVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 09:21:47 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: forkbombing Linux distributions
Date: Wed, 23 Mar 2005 15:20:51 +0100
Message-ID: <yw1xsm2mqw8s.fsf@ford.inprovide.com>
References: <e0716e9f05032019064c7b1cec@mail.gmail.com> <20050322112628.GA18256@roll>
 <Pine.LNX.4.61.0503221247450.5858@yvahk01.tjqt.qr>
 <20050322124812.GB18256@roll> <20050322125025.GA9038@roll>
 <9cde8bff050323025663637241@mail.gmail.com> <1111581459.27969.36.camel@nc>
 <9cde8bff05032305044f55acf3@mail.gmail.com> <1111586058.27969.72.camel@nc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:i+UIeVIRmCc8udGDOpaXB1Zhp/o=
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Natanael Copa <mlists@tanael.org> writes:

> well, the problem here has that stupid fork bombs like:
>
> :() { :|:& };:
>
> brings down almost all linux distro's while other *nixes survives.

I have seen a SunFire machine with 4GB RAM running Solaris grind to a
complete halt from a fork bomb.

-- 
Måns Rullgård
mru@inprovide.com

