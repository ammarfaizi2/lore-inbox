Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760259AbWLFHF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760259AbWLFHF7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 02:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760278AbWLFHF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 02:05:58 -0500
Received: from src.samsung.ru ([194.133.69.66]:2733 "EHLO src.samsung.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760259AbWLFHF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 02:05:58 -0500
Message-ID: <01ca01c71904$f92b3330$da096d6a@rnd.samsung.ru>
From: "Denis Silin" <denis.silin@src.samsung.ru>
To: <linux-kernel@vger.kernel.org>
Subject: Where is SIG_DFL in kernel source?
Date: Wed, 6 Dec 2006 10:05:55 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="koi8-r";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-SMTP-HELO: silindenis
X-SMTP-MAIL-FROM: denis.silin@src.samsung.ru
X-SMTP-RCPT-TO: linux-kernel@vger.kernel.org,linux-kernel@vger.kernel.org
X-SMTP-PEER-INFO: 106-109-9-218.samsung.ru [106.109.9.218]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
 
What function kills a process when a signal arrives? Where is it called?

