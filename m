Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWIZX1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWIZX1M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 19:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWIZX1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 19:27:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:6037 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932454AbWIZX1L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 19:27:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=uoSD78UlR+W3YieWQ2i+hjDwLLf7+2jVRGy2Tm3QolW3O5ep8HT7Ozt7TdKtYnuAfydpUc9sILIXTw8554X8F9SZwv8A+3fpVGjUuoO+0lV826GVECcx2wSNPWt62PXCmhrYiILktjLRi71Rn15940IJUIzGtE87TWK9ujZkSyI=
Date: Wed, 27 Sep 2006 01:27:06 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Diego Calleja <diegocg@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, jeff@garzik.org, linux-kernel@vger.kernel.org
Subject: Re: pata_serverworks oopses in latest -git
Message-Id: <20060927012706.7cb99f66.diegocg@gmail.com>
In-Reply-To: <20060927005813.09154c74.diegocg@gmail.com>
References: <20060926140016.54d532ba.diegocg@gmail.com>
	<1159275010.11049.215.camel@localhost.localdomain>
	<45194DAD.6060904@garzik.org>
	<20060926212939.69b52f0d.diegocg@gmail.com>
	<1159300946.11049.300.camel@localhost.localdomain>
	<20060926223857.56b0047d.diegocg@gmail.com>
	<1159305871.11049.316.camel@localhost.localdomain>
	<20060927002149.06c934e8.diegocg@gmail.com>
	<1159312008.11049.323.camel@localhost.localdomain>
	<20060927005813.09154c74.diegocg@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 27 Sep 2006 00:58:13 +0200,
Diego Calleja <diegocg@gmail.com> escribió:

> Mmh, this dvd does work with the old ide driver. I've tested other
> DVDs and it always happens, but this is very weird...totem is able
> to read it for 3 or 4 seconds, then totem hangs, it popups an error,
> and I'll get error messages in dmesg:

Weird, and I'll get the same error with CDs, it just took longer to
stop submitting data
