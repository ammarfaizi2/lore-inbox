Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130063AbRA3VGH>; Tue, 30 Jan 2001 16:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130282AbRA3VF6>; Tue, 30 Jan 2001 16:05:58 -0500
Received: from snowbird.megapath.net ([216.200.176.7]:43534 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S130063AbRA3VFm>;
	Tue, 30 Jan 2001 16:05:42 -0500
Message-ID: <3A772D3C.CB62DD4F@megapath.net>
Date: Tue, 30 Jan 2001 13:08:12 -0800
From: Miles Lane <miles@megapath.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Ruurd Reitsma <R.A.Reitsma@wbmt.tudelft.nl>,
        Norberto Pellicci <pellicci@home.com>
Subject: 2.4.1 -- Unresolved symbols in radio-miropcm20.o
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

depmod: *** Unresolved symbols in
/lib/modules/2.4.1/kernel/drivers/media/radio/radio-miropcm20.o
depmod: 	aci_write_cmd
depmod: 	aci_indexed_cmd
depmod: 	aci_write_cmd_d
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
