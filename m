Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVDSJBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVDSJBO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 05:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVDSJBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 05:01:14 -0400
Received: from mail.dif.dk ([193.138.115.101]:3722 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261153AbVDSJBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 05:01:13 -0400
Date: Tue, 19 Apr 2005 11:04:13 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sha512: replace open-coded be64 conversions
In-Reply-To: <200504190921.34294.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.62.0504191102360.2480@dragon.hyggekrogen.localhost>
References: <200504190918.10279.vda@port.imtp.ilyichevsk.odessa.ua>
 <200504190921.34294.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2005, Denis Vlasenko wrote:

> This + next patch were "modprobe tcrypt" tested.
> See next mail.

Could you please send patches inline instead of as attachments. 
Attachments mean there's more work involved in getting at them to read 
them, and they are a pain when you want to reply and quote the patch to 
comment on it.
Thanks.

-- 
Jesper

