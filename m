Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264483AbTDPQtU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264453AbTDPQtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:49:13 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:36292
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264454AbTDPQrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:47:35 -0400
Subject: RE: [2.4.21-pre7-ac1] IDE Warning when booting
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Mudama, Eric" <eric_mudama@maxtor.com>
Cc: "'hps@intermeta.de'" <hps@intermeta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <785F348679A4D5119A0C009027DE33C102E0D12A@mcoexc04.mlm.maxtor.com>
References: <785F348679A4D5119A0C009027DE33C102E0D12A@mcoexc04.mlm.maxtor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050508122.28591.128.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Apr 2003 16:48:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-16 at 17:25, Mudama, Eric wrote:
> However, the ID block also reports the maximum multiple count in word 47
> bits 7..0, so if that was non zero, the drive shouldn't abort it.

I don't believe we check that word (I didn't know about it either). I'll
take a look at that right now

Thanks
Alan

