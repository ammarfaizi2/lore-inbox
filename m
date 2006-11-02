Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752844AbWKBNSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbWKBNSq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 08:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752845AbWKBNSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 08:18:45 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47550 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1752844AbWKBNSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 08:18:41 -0500
Subject: Re: hdb lost interrupt
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Manu Abraham <abraham.manu@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4549B305.7040106@gmail.com>
References: <4549B305.7040106@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 02 Nov 2006 13:11:27 +0000
Message-Id: <1162473087.11965.182.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-11-02 am 12:57 +0400, ysgrifennodd Manu Abraham:
> Any idea as to what could be causing the lost interrupt ?

It may have been a drive fault. Check the SMART information on the drive
and see what the disk has logged recently.


