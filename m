Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266670AbUHQT5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266670AbUHQT5G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 15:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268360AbUHQT5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 15:57:06 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:8466 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266670AbUHQT5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 15:57:03 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: lkml problem
Date: Tue, 17 Aug 2004 22:56:54 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408172256.54881.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

Can you check why do my mails stopped appearing on
lkml lately? My SMTP server reports them as accepted:

info msg 192270: bytes 23472 from <vda@port.imtp.ilyichevsk.odessa.ua> qp 21977 uid 80
starting delivery 440: msg 192270 to remote arjanv@redhat.com
starting delivery 441: msg 192270 to remote Jens.Maurer@gmx.net
starting delivery 442: msg 192270 to remote linux-kernel@vger.kernel.org
delivery 442: success: 12.107.209.244_accepted_message./Remote_host_said:_250_2.7.0_nothing_apparently_wrong_i
delivery 440: success: 66.187.233.31_accepted_message./Remote_host_said:_250_2.0.0_i7HHVve1030758_Message_acce
delivery 441: success: 213.165.64.100_accepted_message./Remote_host_said:_250_2.6.0_{mx028}_Message_accepted/

My SMTP server's IP is 195.66.192.168
--
vda

