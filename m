Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264579AbUGFV4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264579AbUGFV4b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 17:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbUGFV4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 17:56:30 -0400
Received: from havoc.gtf.org ([216.162.42.101]:1170 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264633AbUGFV40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 17:56:26 -0400
Date: Tue, 6 Jul 2004 17:56:22 -0400
From: David Eger <eger@havoc.gtf.org>
To: linux-kernel@vger.kernel.org
Subject: 0xdeadbeef vs 0xdeadbeefL
Message-ID: <20040706215622.GA9505@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a reason to add the 'L' to such a 32-bit constant like this?
There doesn't seem a great rhyme to it in the headers...

-dte
