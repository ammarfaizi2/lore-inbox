Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWCMIBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWCMIBD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 03:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWCMIBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 03:01:01 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54466 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932332AbWCMIBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 03:01:01 -0500
Subject: Re: [PATCH] KERN_SETUID_DUMPABLE in /proc/sys/fs/
From: Arjan van de Ven <arjan@infradead.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, garloff@suse.de,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <m1r757xqoc.fsf@ebiederm.dsl.xmission.com>
References: <20060310155738.GL5766@tpkurt.garloff.de>
	 <20060310145605.08bf2a67.akpm@osdl.org>
	 <1142061816.3055.6.camel@laptopd505.fenrus.org>
	 <20060310234155.685456cd.akpm@osdl.org>
	 <1142063254.3055.9.camel@laptopd505.fenrus.org>
	 <20060310235103.4e9c9457.akpm@osdl.org>
	 <1142064294.3055.13.camel@laptopd505.fenrus.org>
	 <m1r757xqoc.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 09:00:42 +0100
Message-Id: <1142236842.3023.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This must be number 69 here.  Or else we break the sys_sysctl ABI.

numeric sysctl abi is since 2.6.0 no longer an ABI though; anything
after that.. not an ABI :)


