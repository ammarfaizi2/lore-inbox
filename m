Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264304AbTFIHiY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 03:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbTFIHiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 03:38:24 -0400
Received: from mout1.freenet.de ([194.97.50.132]:36272 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S264304AbTFIHiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 03:38:23 -0400
From: Andreas Hartmann <andihartmann@freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: Re: [2.4.17rc7] broken IO-APIC support with MPS 1.4
Date: Mon, 09 Jun 2003 09:58:00 +0200
Organization: privat
Message-ID: <bc1em8$348$1@ID-44327.news.dfncis.de>
References: <bc1bfu$28r$1@ID-44327.news.dfncis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: susi.maya.org 1055145480 3208 192.168.1.3 (9 Jun 2003 07:58:00 GMT)
X-Complaints-To: abuse@fu-berlin.de
User-Agent: KNode/0.7.2
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Some additional infos:

- It seems to be only randomly working when using MPS 1.1. I never saw it
working with MPS 1.4.

- The same problem occures with rc6 (I didn't test the prior versions).



Kind regards,
Andreas Hartmann
