Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268074AbUHVSss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268074AbUHVSss (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 14:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268075AbUHVSss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 14:48:48 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:43906 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S268074AbUHVSsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 14:48:45 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.8.1: swap storm of death - 2.6.8.1-mm4 also
References: <200408221527.10303.karl.vogel@seagha.com>
From: karl.vogel@seagha.com
Date: Sun, 22 Aug 2004 20:49:17 +0200
In-Reply-To: <200408221527.10303.karl.vogel@seagha.com> (Karl Vogel's
 message of "Sun, 22 Aug 2004 15:27:10 +0200")
Message-ID: <m38yc757pu.fsf@seagha.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried if I could trigger the same swap of death on 2.6.8.1-mm4.
It appears I could :(

I will have another go at it with elevator=as and see if that makes
a difference.


