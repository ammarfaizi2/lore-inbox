Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265941AbUBQC0A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 21:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265972AbUBQC0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 21:26:00 -0500
Received: from ms-smtp-01-smtplb.rdc-nyc.rr.com ([24.29.109.5]:40374 "EHLO
	ms-smtp-01.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S265941AbUBQCZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 21:25:59 -0500
Date: Mon, 16 Feb 2004 21:26:05 -0500
From: Huw Rogers <count0@localnet.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.3-rc3-mm1 - COMPILE FAILURE
In-Reply-To: <20040201151411.3A7B.COUNT0@localnet.com>
References: <37778.199.172.169.20.1075236597.squirrel@webmail.localnet.com> <20040201151411.3A7B.COUNT0@localnet.com>
Message-Id: <20040216212241.AD1B.COUNT0@localnet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.07.04 [en]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ext3_quota_on() defined at lines 144352-144377 of 2.6.3-rc3-mm1 does
not compile (it does not have matching braces!!!); need CONFIG_QUOTA
to see the failure.

-- 
Huw Rogers <count0@localnet.com>

