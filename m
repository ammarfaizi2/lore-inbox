Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbUDIHyj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 03:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUDIHyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 03:54:39 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:43023 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261862AbUDIHyj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 03:54:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Paul Jackson <pj@sgi.com>
Subject: Re: [Patch 17/23] mask v2 = [6/7] nodemask_t_ia64_changes
Date: Fri, 9 Apr 2004 10:54:24 +0300
X-Mailer: KMail [version 1.4]
Cc: colpatch@us.ibm.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
References: <20040401122802.23521599.pj@sgi.com> <20040406235000.6c06af9a.pj@sgi.com> <20040407004437.3a078f28.pj@sgi.com>
In-Reply-To: <20040407004437.3a078f28.pj@sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200404091054.24618.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 April 2004 10:44, Paul Jackson wrote:
> Several architectures have this large version of find_next_bit() code.
>
> It may well make sense for the O(1) scheduler to be inlining this.

Why?
-- 
vda
