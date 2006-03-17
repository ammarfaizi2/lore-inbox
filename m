Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbWCQSPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbWCQSPS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 13:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbWCQSPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 13:15:18 -0500
Received: from mail.linicks.net ([217.204.244.146]:62356 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1030249AbWCQSPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 13:15:17 -0500
From: Nick Warne <nick@linicks.net>
To: Linda Walsh <lkml@tlinx.org>, linux-kernel@vger.kernel.org
Subject: Re: chmod 111
Date: Fri, 17 Mar 2006 18:14:13 +0000
User-Agent: KMail/1.9.1
References: <200603171746.18894.nick@linicks.net> <441AFBF5.7010009@tlinx.org>
In-Reply-To: <441AFBF5.7010009@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603171814.13424.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 March 2006 18:12, Linda Walsh wrote:
> Don't confused the kernel's access with your access.
> Execute-only means user can't read it.  The kernel isn't restricted
> by the file permissions.

Ah!  I see.  Explained perfectly.

Thanks,

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
