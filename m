Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264979AbTFCMac (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 08:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264981AbTFCMac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 08:30:32 -0400
Received: from imsantv20.netvigator.com ([210.87.250.76]:19931 "EHLO
	imsantv20.netvigator.com") by vger.kernel.org with ESMTP
	id S264979AbTFCMab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 08:30:31 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Jakob Oestergaard <jakob@unthought.net>
Subject: Re: NFS io errors on transfer from system running 2.4 to system running 2.5
Date: Tue, 3 Jun 2003 20:43:28 +0800
User-Agent: KMail/1.5.2
References: <200306031912.53569.mflt1@micrologica.com.hk> <20030603122411.GB14947@unthought.net>
In-Reply-To: <20030603122411.GB14947@unthought.net>
Cc: linux-kernel@vger.kernel.org
X-OS: GNU/Linux 2.5.70
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306032043.28141.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 June 2003 20:24, Jakob Oestergaard wrote:
> > When doing rsync or cp _from_ system running 2.4 _to_ system running 2.5
> > get Input/output error errors with random files.
>
> Do you use soft mounts?

Yes

>
> If so, try hard instead. soft will fail, sooner or later.

I don't like hard mounts because these do not timeout.

Also, this does not explain why 2.5 > 2.4 (and 2.4 > 2.4) is OK - _never_ had any problem  

Regards
Michael

