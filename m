Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVALXak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVALXak (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 18:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVALX3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 18:29:50 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:17369 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261560AbVALX1T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 18:27:19 -0500
Date: Wed, 12 Jan 2005 23:28:30 +0000
From: Willem Riede <osst@riede.org>
Subject: Re: [PATCH 1/3] osst upgrade to 0.99.3
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <1104627552l.3427l.2l@serve.riede.org>
	<20050105151819.1a4981ae.akpm@osdl.org>
In-Reply-To: <20050105151819.1a4981ae.akpm@osdl.org> (from akpm@osdl.org on
	Wed Jan  5 18:18:19 2005)
X-Mailer: Balsa 2.2.6
Message-Id: <1105572510l.8514l.0l@serve.riede.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2005 06:18:19 PM, Andrew Morton wrote:
> Willem Riede <osst@riede.org> wrote:
> >
> > In a series of three mails, I'll present changes I'd like to see 
> >  made to the osst driver in the linux-2.6.11 pre-series.
> 
> All three patches were hopelessly mangled by your email client:
> 
> 70 out of 70 hunks FAILED -- saving rejects to file drivers/scsi/osst.c.rej
> osst-style-changes does not apply

I'm confused - James Bottomley pulled those patches into scsi-bk from my  
mails, and they are present in 2.6.10-mm1...

> When resending please ensure that the patch headers are in `-p1' form:
> Also, please don't send multiple patches under the same Subject:.

James Bottomley chastised me for that too, so I solemny swear never to make  
that mistake again :-)

Regards, Willem Riede.

