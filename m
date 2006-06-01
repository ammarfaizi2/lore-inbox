Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbWFAP6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWFAP6h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 11:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbWFAP6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 11:58:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:1550 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030202AbWFAP6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 11:58:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EmtxS0i3RsNiAM27GwocRzxNuFidlzy/1m7e8WLWRaGFS39PKcm2vOhsPsJrkHhVXsxG0U1dFA40LZEkMc1QN8wt9RMVo72LGFRqnq9l0fq9Uzrazq5ozC1/7cJzZ6TxRvzCPqwmp66K641bFEaXydzrUD8jm2ksMrPpIORjlPw=
Message-ID: <82ecf08e0606010858u3a31c46bx6bb8c340580cb993@mail.gmail.com>
Date: Thu, 1 Jun 2006 12:58:34 -0300
From: "Thiago Galesi" <thiagogalesi@gmail.com>
To: "Keith Chew" <keith.chew@gmail.com>
Subject: Re: IO APIC IRQ assignment
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20f65d530606010835h76356757k3d3714203d5e4c6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20f65d530605300521q1d56c3a3t84be3d92f1df0c14@mail.gmail.com>
	 <20060530135017.GD5151@harddisk-recovery.com>
	 <20f65d530605300705l60bfcca7k47a41c95bf42a0ef@mail.gmail.com>
	 <Pine.LNX.4.61.0606010002200.30170@yvahk01.tjqt.qr>
	 <20f65d530605311612n15820847sca559d0c443fc230@mail.gmail.com>
	 <20060601094214.GA14431@harddisk-recovery.com>
	 <20f65d530606010338h23dbd152u2670000ba6130fc6@mail.gmail.com>
	 <20f65d530606010835h76356757k3d3714203d5e4c6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a side note, did you consider that, for that purpose, the system
you're using may be underpowered (that is, not enough CPU / Bus
speed)??

Depending on your system configuration, plus frequency and resolution
of frame acquisition, yes, it's not going to work.

Maybe using an external Wifi<>Ethernet bridge is going to lighten the
system load (those USB adapters probably do most of the work in the
host system)

I've already encountered the PCI latency problem in a similar project
(using BTTVs, the image would be missing some lines) with not so
frequent captures and two BTTVs on the system)

Just my 2c...
