Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266459AbUJEXwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266459AbUJEXwT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 19:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266460AbUJEXwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 19:52:18 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:34216 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266459AbUJEXuz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 19:50:55 -0400
Subject: Re: hpt366 under hpt372N oops
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?ISO-8859-1?Q?Jo=E3o?= Luis Meloni Assirati 
	<assirati@nonada.if.usp.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200410050638.13426.assirati@nonada.if.usp.br>
References: <200410050638.13426.assirati@nonada.if.usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1097016504.23924.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 05 Oct 2004 23:48:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-10-05 at 10:38, João Luis Meloni Assirati wrote:
> Hello,
> 
> I have an off board HighPoint RocketRAID 133 pci card. The chip is identified 
> as HPT372N and there is a tag in the board printed V2.35.

Is this crash fixed by 2.6.9rc3 for you - its my fault I'm afraid I
slightly screwed up merging 2.4.2x HPT372N into 2.6.x

