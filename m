Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWGRNtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWGRNtY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 09:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWGRNtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 09:49:24 -0400
Received: from mail.atl.external.lmco.com ([192.35.37.50]:23527 "EHLO
	enterprise.atl.lmco.com") by vger.kernel.org with ESMTP
	id S932205AbWGRNtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 09:49:23 -0400
Message-ID: <44BCE6E2.3050705@atl.lmco.com>
Date: Tue, 18 Jul 2006 09:49:22 -0400
From: Jonathan Walsh <jwalsh@atl.lmco.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rt1: oprofile doesn't work anymore
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To reply to an old thread... I can confirm the problem as I am also not
getting any samples from oprofile on 2.6.17-rt7.

root@node> cat /dev/oprofile/stats/cpu0/sample_received
0

-Jonathan Walsh
Distributed Processing Lab; Lockheed Martin Adv. Tech. Labs
