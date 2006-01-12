Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbWALRg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWALRg3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWALRg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:36:29 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:18844 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932432AbWALRg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:36:28 -0500
Date: Thu, 12 Jan 2006 09:35:11 -0800
From: Paul Jackson <pj@sgi.com>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: akpm@osdl.org, kurosawa@valinux.co.jp, simon.derr@bull.net,
       linux-kernel@vger.kernel.org, st@sw.ru, dev@sw.ru, den@sw.ru
Subject: Re: [PATCH] cpuset oom lock fix
Message-Id: <20060112093511.033465b5.pj@sgi.com>
In-Reply-To: <43C6925C.1040307@us.ibm.com>
References: <20060112091627.18409.49780.sendpatchset@jackhammer.engr.sgi.com>
	<43C6925C.1040307@us.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darrick wrote:
> the patched kernel hasn't exhibited this crash yet;

Good - thanks.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
