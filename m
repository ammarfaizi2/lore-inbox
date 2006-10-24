Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161024AbWJXM1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbWJXM1V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 08:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161022AbWJXM1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 08:27:21 -0400
Received: from ns.suse.de ([195.135.220.2]:210 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161024AbWJXM1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 08:27:20 -0400
From: Andi Kleen <ak@suse.de>
To: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 5/13] KVM: virtualization infrastructure
Date: Mon, 23 Oct 2006 22:19:45 -0700
User-Agent: KMail/1.9.1
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <453CC390.9080508@qumranet.com> <200610232235.29287.arnd@arndb.de> <453E0108.3080502@qumranet.com>
In-Reply-To: <453E0108.3080502@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610232219.46369.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> Andi, will you accept a patch to move it to asm-i386/desc_defs.h so it
> can be used in both archs?

No. But a asm-x86_64/desc_defs.h would be ok, you can include that
then.

-Andi
