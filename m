Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbWGKHHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbWGKHHa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030318AbWGKHH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:07:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:19611 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030231AbWGKHH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:07:29 -0400
Subject: Re: [PATCH] sysctl: Document that sys_sysctl will be removed.
From: Arjan van de Ven <arjan@infradead.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <m1veq4kcij.fsf@ebiederm.dsl.xmission.com>
References: <m1psgdkrt8.fsf@ebiederm.dsl.xmission.com>
	 <20060710155051.326e49da.rdunlap@xenotime.net>
	 <m1veq4kcij.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 09:07:20 +0200
Message-Id: <1152601640.3128.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The comment about kernel.version is odd. That information is available in
> uname so I can't imagine why sys_sysctl would be an interesting source.

glibc used it (pass tense); sometimes it's better to not ask why ;)


