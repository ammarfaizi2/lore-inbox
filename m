Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWAFVl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWAFVl1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 16:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWAFVl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 16:41:26 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:53952 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751431AbWAFVl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 16:41:26 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [PATCH 3/3] updated *at function patch
To: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org
Reply-To: 7eggert@gmx.de
Date: Fri, 06 Jan 2006 22:45:04 +0100
References: <5s5sB-p4-181@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EuzOT-0000jw-1g@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper <drepper@redhat.com> wrote:

> +#define __NR_fchownat                259
> +__SYSCALL(__NR_fchownat, sys_fchownat)

s/fchown/chown/ ?
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
