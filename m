Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264298AbUEDKBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264298AbUEDKBV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 06:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUEDKBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 06:01:21 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:2064 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S264298AbUEDKBH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 06:01:07 -0400
To: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3 + cset-20040503_1619 = umsdos error
References: <Pine.LNX.4.58L.0405041038430.31773@alpha.zarz.agh.edu.pl>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 04 May 2004 19:00:37 +0900
In-Reply-To: <Pine.LNX.4.58L.0405041038430.31773@alpha.zarz.agh.edu.pl>
Message-ID: <87n04ose9m.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wojciech 'Sas' Cieciwa <cieciwa@alpha.zarz.agh.edu.pl> writes:

> I try to build 2.6.6-rc3 and cset-20040503_1619 and got error:

Yes, umsdos is breaking a long time. (it need rewrite more or less)
Doesn't "make oldconfig" removes the CONFIG_UMSDOS_FS from ".config"?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
