Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbULPX2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbULPX2e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 18:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbULPX2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 18:28:33 -0500
Received: from salazar.rnl.ist.utl.pt ([193.136.164.251]:37087 "EHLO
	admin.rnl.ist.utl.pt") by vger.kernel.org with ESMTP
	id S262062AbULPX2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 18:28:30 -0500
Message-ID: <41C21A1A.7010606@rnl.ist.utl.pt>
Date: Thu, 16 Dec 2004 23:28:26 +0000
From: "Pedro Venda (SYSADM)" <pjvenda@rnl.ist.utl.pt>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Conway <nconway_kernel@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3TB disk hassles
References: <20041216145229.29167.qmail@web26502.mail.ukl.yahoo.com>
In-Reply-To: <20041216145229.29167.qmail@web26502.mail.ukl.yahoo.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Conway wrote:
> Howdy...
> 
> After much banging of heads on walls, I am throwing in the towel and
> asking the experts ;-) ... To cut a long story short:
> 
> Is it possible to make a 3TB disk work properly in Linux?
> 
> Our "disk" is 12x300GB in RAID5 (with 1 hot-spare) on a 3ware 9500-S12,
> so it's actually 2.7TiB ish.  It's also /dev/sda - i.e., the one and
> only disk in the system.

not meaning to criticise... but isn't it a good idea to have a separate raid1 
volume to boot the system?

is there a good reason why one should mix system & storage?

I think that would solve your problem.

regards,
pedro venda.

-- 

Pedro João Lopes Venda
email: pjvenda@rnl.ist.utl.pt
http://maxwell.rnl.ist.utl.pt

Equipa de Administração de Sistemas
Rede das Novas Licenciaturas (RNL)
Instituto Superior Técnico
http://www.rnl.ist.utl.pt
http://mega.ist.utl.pt
