Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262497AbTCRSuj>; Tue, 18 Mar 2003 13:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262504AbTCRSui>; Tue, 18 Mar 2003 13:50:38 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:33261
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262497AbTCRSui>; Tue, 18 Mar 2003 13:50:38 -0500
Subject: Re: [2.5.65] Hangs at boot: typhoon-radio and i2o_scsi
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vagn Scott <vagn@ranok.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E18vLfd-00008I-00@Maya.ny.ranok.com>
References: <E18vLfd-00008I-00@Maya.ny.ranok.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048018318.27223.86.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 18 Mar 2003 20:11:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-18 at 18:18, Vagn Scott wrote:
> I don't happen to have such a device.
> So unselect that and try again:
> 
> i2o_scsi.c: version 0.1.2
>   chain_pool: 0 bytes @ f79e3bc0
>   (512 byte buffers X 4 can_queue X 0 i2o controllers)
> 
> I don't have any i20 gear either...
> unselect I2O SCSI and try again:

Known problem. I should be sending Linus the next i2o stuff soon

