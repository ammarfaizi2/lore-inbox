Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264714AbTFAT2b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 15:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264717AbTFAT2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 15:28:31 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:31941 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S264714AbTFAT23
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 15:28:29 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Byron Stanoszek <gandalf@winds.org>, Mike Fedyk <mfedyk@matchmail.com>,
       Alexandre Pereira Nunes <alex@PolesApart.wox.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-rc6 ide-scsi bug?
Mail-Copies-To: never
References: <Pine.LNX.4.44.0305311858370.5395-100000@winds.org>
	<1054422394.28853.2.camel@dhcp22.swansea.linux.org.uk>
	<87y90mkq9l.fsf@free.fr>
From: Roland Mas <roland.mas@free.fr>
Date: Sun, 01 Jun 2003 21:41:39 +0200
Message-ID: <87n0h14mbw.fsf@free.fr>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Mas, 2003-06-01 13:09:58 +0200 :

[...]

> I seem to have the same problem, or at least a very similar one.  I
> reported it in a message with subject "[OOPS] ide-ops:1262 in
> 2.4.21-rc3", posted to LKML last Sunday.  You might like to read that
> message (it includes a ksymoops'ed panic trace).  I have since then
> been able to reproduce with 2.4.21-rc6.  I will try to get a more
> detailed analysis today, and post it tonight.

Done, in a message with subject "[OOPS] ide-scsi panic in 2.4.21-rc2,
-rc3, -rc6, -rc6-ac1", Cc:ed to various people.

Roland.
-- 
Roland Mas

C   c e    e l    m  re q   j  l   a l  l  iè e  .
  -- Signatures à collectionner, série n°1, partie 3/3.
