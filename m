Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264923AbUHSKDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264923AbUHSKDY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 06:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUHSKDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 06:03:23 -0400
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:61072 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264915AbUHSKAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 06:00:00 -0400
Subject: Re: [PATCH] bio_uncopy_user mem leak
From: Greg Afinogenov <antisthenes@inbox.ru>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1092909598.8364.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 19 Aug 2004 04:59:58 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd just like to point out that this patch does not, as may be expected,
result in functional audio CDs.  It merely results in a successful burn
process and a CD full of noise.

Perhaps this should be tested/fixed?

Greg

(I'm not subscribed to this list; please CC me any responses; thanks!)

 

