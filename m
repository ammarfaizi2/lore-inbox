Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbTFBLp5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 07:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbTFBLp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 07:45:57 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:1770 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S262237AbTFBLp4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 07:45:56 -0400
From: Con Kolivas <kernel@kolivas.org>
To: =?iso-8859-15?q?J=E9r=F4me=20Aug=E9?= <jauge@club-internet.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 can't set IDE DMA on harddrive (HDIO_SET_DMA failed: Operation not permitted)
Date: Mon, 2 Jun 2003 22:00:37 +1000
User-Agent: KMail/1.5.1
References: <20030602114838.GA1730@satellite.workgroup.fr>
In-Reply-To: <20030602114838.GA1730@satellite.workgroup.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200306022200.37685.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jun 2003 21:48, Jérôme Augé wrote:
> Hi,
>
> I'm now using kernel 2.4.20-13.8 (from RH8) and 2.4.21-ck1 (from Con
> Kolivas based on 2.4.21-rc6) and I'm unable to set the dma for my
> harddrive with hdparm:

Feel free to blame me, but I haven't formally released 2.4.21-ck1, and you 
should really try the vanilla 2.4.21-rc kernel. Then you can post a bug 
report that the actual IDE developers can look at. Mine is a non-standard 
kernel tree and bug reports with that branch should just be directed to me.

Con
