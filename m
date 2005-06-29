Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262689AbVF2WcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbVF2WcY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 18:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVF2WcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 18:32:24 -0400
Received: from mx.ticino.com ([195.190.166.60]:39186 "EHLO mail1.ticino.com")
	by vger.kernel.org with ESMTP id S262689AbVF2WcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 18:32:21 -0400
Message-ID: <42C32199.1080706@kotarkh.ch>
Date: Thu, 30 Jun 2005 00:32:57 +0200
From: nuage <nuage@kotarkh.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050618
X-Accept-Language: en
MIME-Version: 1.0
To: nuage <nuage@kotarkh.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: new hardware problems: IRQ and ACPI (Toshiba Tecra S2-128)
References: <42C2F7B1.7070500@kotarkh.ch>
In-Reply-To: <42C2F7B1.7070500@kotarkh.ch>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After so many tries with different configurations,
I just found out that having my USB mouse pluged in
at boot time will just break everything up. So without
my USB mouse pluged in at boot time, everything is fine.

I hope this can help. Having my mouse pluged out at boot
time is a decent workaround for me. But if you want to
make more tests on my laptop, just ask.

Regards,
Nuage
