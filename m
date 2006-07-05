Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWGEFo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWGEFo6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 01:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWGEFo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 01:44:58 -0400
Received: from fep30-0.kolumbus.fi ([193.229.0.32]:9413 "EHLO
	fep30-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S932460AbWGEFo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 01:44:57 -0400
Date: Wed, 5 Jul 2006 08:44:50 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Nikhil Dharashivkar <nikhildharashivkar@gmail.com>
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: About mtio in Linux.
In-Reply-To: <17db6d3a0607040254v5fa69122wc358436783b29636@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0607050843290.12214@kai.makisara.local>
References: <17db6d3a0607040254v5fa69122wc358436783b29636@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2006, Nikhil Dharashivkar wrote:

> Query is for mtio (magnetic tape IO) on linux. I found
> MTIOCSETEOTMODEL ioctl on freebsd  for mtio. Is there any equivalent
> IOCTl of MTIOCSETEOTMODEL in linux.
> 
For SCSI tapes you have MT_ST_TWO_FM. See 'man st' for details.
-- 
Kai
