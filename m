Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbUCDHDb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 02:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbUCDHDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 02:03:31 -0500
Received: from komp197.tera.com.pl ([81.21.195.197]:29060 "EHLO wrota.net")
	by vger.kernel.org with ESMTP id S261519AbUCDHDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 02:03:30 -0500
Date: Thu, 4 Mar 2004 08:03:29 +0100
From: Daniel Fenert <daniel@fenert.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Is there some bug in ext3 in 2.4.25?
Message-ID: <20040304070329.GA16880@fenert.net>
Mail-Followup-To: Daniel Fenert <daniel@fenert.net>,
	linux-kernel@vger.kernel.org
References: <20040304065038.GV31185@fenert.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040304065038.GV31185@fenert.net>
User-Agent: Mutt/1.4.2i
Organization: Co by tu =?iso-8859-2?B?d3Bpc2HmPyBNb78=?=
	=?iso-8859-2?Q?e?= daniellek.z.domu ? ;)
X-Operating-System: Linux 2.4.24
X-Wyslij-mi-SMSa: Lepiej nie...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu Thu, Mar 04, 2004 at 07:50:38AM +0100, Daniel Fenert wystuka³(a):
>Message from syslogd@lazy at Thu Mar  4 08:31:58 2004 ...
>lazy kernel: Assertion failure in __journal_drop_transaction() at
>checkpoint.c:587: "transaction->t_ilist == NULL"

One more thing - it has happened when /var got full.

-- 
Daniel Fenert              --==> daniel@fenert.net <==--
==-P o w e r e d--b y--S l a c k w a r e-=-ICQ #37739641-==
Absurd: przekonanie sprzeczne z Twoimi pogl±dami - [Ambrose Bierce]
=======- http://daniel.fenert.net/ -=======< +48604628083 >
