Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWH2IqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWH2IqT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 04:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWH2IqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 04:46:19 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:4185 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1750834AbWH2IqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 04:46:19 -0400
Date: Tue, 29 Aug 2006 10:46:17 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: "Limeng [??????]" <avlimeng@kingsoft.net>
Cc: linux-kernel@vger.kernel.org
Subject: [OT] thread identification (was: help)
Message-ID: <20060829084616.GA7584@harddisk-recovery.com>
References: <004a01c6cb42$dbdbc110$8940a8c0@liibook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004a01c6cb42$dbdbc110$8940a8c0@liibook>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2006 at 04:12:18PM +0800, Limeng [??????] wrote:
>     How can I get one thread???s  LWP id on linux??? 

See gettid(2).

>     The thread is not the main thread, so that getpid() does not
>     work. And the LWP id is not the same as the result by
>     pthread_self().
> 
>     Any suggestion?

Don't ask it over here, this list is about kernel development, not
about pthread questions.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
