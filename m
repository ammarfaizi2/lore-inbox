Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272314AbTHIKPK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 06:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272315AbTHIKPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 06:15:09 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:1287 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S272314AbTHIKPH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 06:15:07 -0400
Date: Sat, 9 Aug 2003 12:11:48 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       davem@redhat.com
Subject: Re: [PATCH] TRY #2 - 2.6.0-test2-bk8 - seq_file conversion of /proc/net/atm
Message-ID: <20030809121148.A8177@electric-eye.fr.zoreil.com>
References: <20030809000303.A2699@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030809000303.A2699@electric-eye.fr.zoreil.com>; from romieu@fr.zoreil.com on Sat, Aug 09, 2003 at 12:03:03AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re,

Assuming some people are willing to test but don't want to play with a stack
of patches, there is a single patch including the whole serie of changes at:
<URL:http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.0-test3/extra/atm-seq_file.patch>

Patch should be 2.6.0-test2-xxx agnostic.

Please test and send full content of /proc/net/atm before/after the patch if
things change.

--
Ueimor
