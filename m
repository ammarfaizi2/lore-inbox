Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266711AbUAWWfY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 17:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266665AbUAWWfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 17:35:24 -0500
Received: from smtp.wp.pl ([212.77.101.160]:26282 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S266711AbUAWWe7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 17:34:59 -0500
Date: Fri, 23 Jan 2004 23:34:57 +0100
From: "=?ISO-8859-2?Q?Rafa=B3?= 'rmrmg' Roszak" <rmrmg@wp.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.25-pre7
Message-Id: <20040123233457.4400d715.rmrmg@wp.pl>
In-Reply-To: <Pine.LNX.4.58L.0401231652020.19820@logos.cnet>
References: <Pine.LNX.4.58L.0401231652020.19820@logos.cnet>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__23_Jan_2004_23_34_57_+0100_9+jKG.AkdQv1K=Y3"
X-AntiVirus: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-ChangeAV: 0
X-WP-AntySpam-Rezultat: NIE-SPAM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Fri__23_Jan_2004_23_34_57_+0100_9+jKG.AkdQv1K=Y3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

begin  Marcelo Tosatti <marcelo.tosatti@cyclades.com> quote:

> Here goes -pre number 7 of 2.4.25 series.


#v+

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.25-pre7;
fi depmod: *** Unresolved symbols in
/lib/modules/2.4.25-pre7/kernel/drivers/media/video/bttv.o depmod: 
i2c_master_recv_R43f1fb54 depmod: 	i2c_bit_add_bus_Rfffabe1b
depmod: 	i2c_bit_del_bus_R1100f0f3
depmod: 	i2c_master_send_Race048b9
depmod: *** Unresolved symbols in
/lib/modules/2.4.25-pre7/kernel/drivers/media/video/msp3400.o depmod: 
i2c_detach_client_R9f8e12b7 depmod: 	i2c_attach_client_R55afad1a
depmod: 	i2c_transfer_Rbd54062b
depmod: 	i2c_del_driver_Rcca56a4c
depmod: 	i2c_probe_Rb60c5768
depmod: 	i2c_add_driver_Rcb6691c5
depmod: 	i2c_master_send_Race048b9
depmod: *** Unresolved symbols in
/lib/modules/2.4.25-pre7/kernel/drivers/media/video/tda7432.o depmod: 
i2c_detach_client_R9f8e12b7 depmod: 	i2c_attach_client_R55afad1a
depmod: 	i2c_del_driver_Rcca56a4c
depmod: 	i2c_probe_Rb60c5768
depmod: 	i2c_add_driver_Rcb6691c5
depmod: 	i2c_master_send_Race048b9
depmod: *** Unresolved symbols in
/lib/modules/2.4.25-pre7/kernel/drivers/media/video/tda9875.o depmod: 
i2c_detach_client_R9f8e12b7 depmod: 	i2c_attach_client_R55afad1a
depmod: 	i2c_transfer_Rbd54062b
depmod: 	i2c_del_driver_Rcca56a4c
depmod: 	i2c_probe_Rb60c5768
depmod: 	i2c_add_driver_Rcb6691c5
depmod: 	i2c_master_send_Race048b9
depmod: *** Unresolved symbols in
/lib/modules/2.4.25-pre7/kernel/drivers/media/video/tda9887.o depmod: 
i2c_detach_client_R9f8e12b7 depmod: 	i2c_attach_client_R55afad1a
depmod: 	i2c_del_driver_Rcca56a4c
depmod: 	i2c_probe_Rb60c5768
depmod: 	i2c_add_driver_Rcb6691c5
depmod: 	i2c_master_send_Race048b9
depmod: *** Unresolved symbols in
/lib/modules/2.4.25-pre7/kernel/drivers/media/video/tuner.o depmod: 
i2c_detach_client_R9f8e12b7 depmod: 	i2c_master_recv_R43f1fb54
depmod: 	i2c_attach_client_R55afad1a
depmod: 	i2c_del_driver_Rcca56a4c
depmod: 	i2c_probe_Rb60c5768
depmod: 	i2c_add_driver_Rcb6691c5
depmod: 	i2c_master_send_Race048b9
depmod: *** Unresolved symbols in
/lib/modules/2.4.25-pre7/kernel/drivers/media/video/tvaudio.o depmod: 
i2c_detach_client_R9f8e12b7 depmod: 	i2c_master_recv_R43f1fb54
depmod: 	i2c_attach_client_R55afad1a
depmod: 	i2c_transfer_Rbd54062b
depmod: 	i2c_del_driver_Rcca56a4c
depmod: 	i2c_probe_Rb60c5768
depmod: 	i2c_add_driver_Rcb6691c5
depmod: 	i2c_master_send_Race048b9
[root@slack:/usr/src/linux-2.4.25-pre7#] 

#v-


-- 
. JID: rmrmg(at)jabberpl(dot)org |   RMRMG   .
.           gg: #2311504         | signature .
.   mail: rmrmg(at)wp(dot)pl     |  version  .
.  registered Linux user 261525  |   0.0.3   .

--Multipart=_Fri__23_Jan_2004_23_34_57_+0100_9+jKG.AkdQv1K=Y3
Content-Type: application/octet-stream;
 name=".config.bz2"
Content-Disposition: attachment;
 filename=".config.bz2"
Content-Transfer-Encoding: base64

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

--Multipart=_Fri__23_Jan_2004_23_34_57_+0100_9+jKG.AkdQv1K=Y3--
