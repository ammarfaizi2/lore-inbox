Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262747AbVHDWxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbVHDWxo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 18:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbVHDWvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 18:51:37 -0400
Received: from gate.crashing.org ([63.228.1.57]:53950 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262727AbVHDWtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 18:49:21 -0400
Subject: Re: Regression: radeonfb: No synchronisation on CRT with
	linux-2.6.13-rc5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bodo Eggert <7eggert@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.58.0508040103100.2220@be1.lrz>
References: <Pine.LNX.4.58.0508040103100.2220@be1.lrz>
Content-Type: text/plain
Date: Fri, 05 Aug 2005 00:44:52 +0200
Message-Id: <1123195493.30257.75.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 00:03 +0200, Bodo Eggert wrote:
> My CRT is out of sync after radeonfb from 2.6.13-rc5 is initialized. 
> 2.6.12 does not show this behaviour.

I'm out of town at the moment, could you maybe diff radeonfb between
working & non-working and CC me the diff ? I don't have my work stuff at
hand not my kernel images so...

Thanks,
Ben.



