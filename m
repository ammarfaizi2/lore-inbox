Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262207AbVANWOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbVANWOE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 17:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbVANWOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 17:14:03 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:33711 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S262195AbVANWMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 17:12:45 -0500
Date: Sat, 15 Jan 2005 01:31:57 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: johnpol@2ka.mipt.ru
Cc: linux-kernel@vger.kernel.org, Michal Ludvig <michal@logix.cz>,
       Fruhwirth Clemens <clemens@endorphin.org>,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       cryptoapi@lists.logix.cz, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/2] CryptoAPI: prepare for processing multiple buffers
 at a time
Message-ID: <20050115013157.46cc788d@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050115013103.05698f1a@zanzibar.2ka.mipt.ru>
References: <20050115013103.05698f1a@zanzibar.2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sat__15_Jan_2005_01_31_57_+0300_4YqoYxTFRq/qubDH"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Sat__15_Jan_2005_01_31_57_+0300_4YqoYxTFRq/qubDH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Jan 2005 01:31:03 +0300
Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

 bd archive - simple in-mamory block device used for test. I currently work 
 	on creating modular loop device replacement based on bd, which could allow
 	network block device to be removed(btw, it is broken at least in 2.6.9)
 	and also allow acrypto module to be used with various tweakable ciphers.
 	I hope that system will provide more flexible control over dataflow
 	than loop device currently does.
 	I recomend following  interesting reading about tweaking ciphers: 
 	http://clemens.endorphin.org/cryptography

	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt

--Multipart=_Sat__15_Jan_2005_01_31_57_+0300_4YqoYxTFRq/qubDH
Content-Type: application/octet-stream;
 name="bd-14_01_2005.tar.gz"
Content-Disposition: attachment;
 filename="bd-14_01_2005.tar.gz"
Content-Transfer-Encoding: base64

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
lD9G2QBQAAA=

--Multipart=_Sat__15_Jan_2005_01_31_57_+0300_4YqoYxTFRq/qubDH--
