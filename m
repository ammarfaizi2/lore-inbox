Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262287AbVCBNTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbVCBNTH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 08:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbVCBNTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 08:19:07 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:61854 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262287AbVCBNTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 08:19:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=IECxFpmZm5p8Js23L7kMUhs+QKYJ0dYQhqnRxiXsCszaXHsiKKqSFewA4No8rGdsOkiLHDRiv6S1wVnn4Y7NRNtgrgKoUc7xHeIYWoVLFHIAEEuK8elMBdpLxE1tIgKBigjBTwRBsZlzb/O9HM7eU8tNMDva/6IfMMmnX3wsU4c=
Message-ID: <5fc59ff30503020519250dc663@mail.gmail.com>
Date: Wed, 2 Mar 2005 05:19:02 -0800
From: Ganesh Venkatesan <ganesh.venkatesan@gmail.com>
Reply-To: Ganesh Venkatesan <ganesh.venkatesan@gmail.com>
To: Zhonghua Dai <zhonghuadai@gmail.com>
Subject: Re: trouble with Dell dimension 3000 network adapter
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5ca13e830503020247676df272@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <5ca13e830503020247676df272@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did you try e100?  What kernel are you using? You could download the
latest e100 from http://sourceforge.net/projects/e1000/.  The latest
version 3.3.6.

ganesh.


On Wed, 2 Mar 2005 18:47:56 +0800, Zhonghua Dai <zhonghuadai@gmail.com> wrote:
> hi,
> 
> I've installed the debian(woody) on my Dell dimension 3000 computer.
> But I can't make the network adapter work, it's type is intel pro/100
> VE network desktop adapter. I've tired such modules as eepro100,
> eexpress, but it doesn't work.
> 
> Any suggestion or information are welcomed?
> 
> Thanks in advance.
> 
> scar
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
