Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262841AbUCWVjr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 16:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262852AbUCWVjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 16:39:47 -0500
Received: from mail.tpgi.com.au ([203.12.160.57]:33412 "EHLO mail1.tpgi.com.au")
	by vger.kernel.org with ESMTP id S262841AbUCWVjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 16:39:43 -0500
Subject: Re: 2.6.4 swsusp on 2 swap partitions?
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040323204822.GB28214@butterfly.hjsoft.com>
References: <20040323204822.GB28214@butterfly.hjsoft.com>
Content-Type: text/plain
Message-Id: <1080074391.12965.3.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Wed, 24 Mar 2004 08:39:52 +1200
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-03-24 at 08:48, John M Flinchbaugh wrote:
> should i be able to suspend across 2 partitions?  i only
> specify one of them in the resume= kernel parameter.

This only works with suspend2. The current in-kernel implementations
only work with one swap partition.

Regards,

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

