Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVENVNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVENVNo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 17:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVENVNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 17:13:44 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43143 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261491AbVENVNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 17:13:41 -0400
Subject: Re: 2.6.9-5.0.5 Oops at journal_commit_transaction
From: Arjan van de Ven <arjan@infradead.org>
To: Leroy van Logchem <leroy.vanlogchem@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b7561c4a05051414057fa7aa12@mail.gmail.com>
References: <b7561c4a05051413465cf1ccc8@mail.gmail.com>
	 <b7561c4a05051414057fa7aa12@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 14 May 2005 23:13:37 +0200
Message-Id: <1116105218.6007.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Distribution vendor and version:
> RedHat Enterprise Linux v4 (updated to 2.6.9-5.0.5)

You really should call Red Hat support... that's what they are there
for, and that is why you pay for RHEL...

> May 14 07:14:01 filera1 kernel: SMP
> May 14 07:14:01 filera1 kernel: Modules linked in: nfsd exportfs
> w83781d adm1021 i2c_sensor i2c_i801 i2c_core nfs lockd sunrpc drbd(U)
> md5 ipv6 autofs4 dm_mod

Are you using ext3 over drbd ??


