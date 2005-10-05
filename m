Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbVJESXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbVJESXm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 14:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030308AbVJESXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 14:23:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57560 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030260AbVJESXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 14:23:42 -0400
Subject: Re: Kernel Panic Error in 2.6.10 !!!!
From: Arjan van de Ven <arjan@infradead.org>
To: umesh chandak <chandak_pict@yahoo.com>
Cc: Badari Pulavarty <pbadari@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20051005174803.70134.qmail@web35905.mail.mud.yahoo.com>
References: <20051005174803.70134.qmail@web35905.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 20:23:27 +0200
Message-Id: <1128536607.2920.49.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.3 (+++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (3.3 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	0.4 PLING_PLING            Subject has lots of exclamation marks
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-05 at 10:48 -0700, umesh chandak wrote:
> hi,
> thanks for reply . 
>  
> But as i am using  gbdb patches on my test machine .i
> don't need initrd ,i am sure about it 

fedora core basically makes an initrd mandatory (udev and all); if you
had used "make istall" it'd have been set up for you fully automatic
including the bootloader

