Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUHQLrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUHQLrT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 07:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUHQLrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 07:47:19 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:40157 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261602AbUHQLrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 07:47:18 -0400
From: Andreas Messer <andreas.messer@gmx.de>
Reply-To: andreas.messer@gmx.de
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: 2.6.8.1 Mis-detect CRDW as CDROM
Date: Tue, 17 Aug 2004 13:47:01 +0200
User-Agent: KMail/1.6.2
References: <200408171114.i7HBExCu028332@burner.fokus.fraunhofer.de>
In-Reply-To: <200408171114.i7HBExCu028332@burner.fokus.fraunhofer.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408171347.01420.satura@proton>
X-ID: G0bkVkZTYeXclMi5b4rx1BxXYggRY7aObLmcmr8oj2kknQULTnMOwR@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
> Judging from the number of reports, I would guess that the Linux kernel is
> much more insecure than cdrecord.
>
> What some people did (chmod on /dev/ entries) was definitely always a
> bigger security risk than running cdrecord suid root.

I, dont think, that running cdrecord suid root is a risk, but i think, that 
there are much more cd-recording applications, not based on cdrecord, which 
may be insecure. Or perhaps someone will write a little programm, wich will 
override the firmware.
I think its a good way to filter the commands within the kernel. Its a 
additional security-barrage. 

Andreas
-- 
gnuPG keyid: 0xE94F63B7 fingerprint: D189 D5E3 FF4B 7E24 E49D 7638 07C5 924C 
E94F 63B7
