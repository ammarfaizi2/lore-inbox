Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266199AbSLPJmC>; Mon, 16 Dec 2002 04:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266278AbSLPJmC>; Mon, 16 Dec 2002 04:42:02 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:35277 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S266199AbSLPJmB>; Mon, 16 Dec 2002 04:42:01 -0500
Message-ID: <2076777.1040031926860.JavaMail.nobody@web55.us.oracle.com>
Date: Mon, 16 Dec 2002 01:45:26 -0800 (PST)
From: "ALESSANDRO.SUARDI" <ALESSANDRO.SUARDI@oracle.com>
To: torvalds@transmeta.com
Subject: Re: Linux v2.5.52
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Mailer: Oracle Webmail Client
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Various things here. Most noticeably more merges with Andrew, with a 
> lot of various small fixes.

Using it, with the addition of Valdis' fix for the Xircom Cardbus PCI
 allocation problem. So far so good, except for IrDA irport that is
 colliding with the serial driver as Jean told me. Not sure why the
 irport-serial problem doesn't bite me in 2.4.x nor did it bite in
 earlier 2.5.x though.

--alessandro
