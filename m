Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbTIWRgS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 13:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbTIWRgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 13:36:18 -0400
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:44038 "EHLO
	ford.pronto.tv") by vger.kernel.org with ESMTP id S262186AbTIWRgQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 13:36:16 -0400
To: linux-kernel@vger.kernel.org
Subject: Supported SATA RAID controllers
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 23 Sep 2003 19:35:37 +0200
Message-ID: <yw1xzngvmmqe.fsf@users.sourceforge.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm looking for some SATA RAID controller supported by Linux.  I want
a real hardware RAID, not just a label.  So far, I've seen 3ware and
Adaptec have some boards that seem to be supported.

Now the question is, will any of these work in a non-intel machine?
If I configure the array on a PC, will it still be accessible on an
Alpha machine?

What about status monitoring?  Do those cards support standard things,
like SMART?

I happen to have an Alpha machine with 64-bit PCI, so it would make a
nice file server with one of those cards.

I've tried mailing 3ware, but they don't seem to reply.

-- 
Måns Rullgård
mru@users.sf.net
