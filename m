Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273590AbRIQMZ4>; Mon, 17 Sep 2001 08:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273587AbRIQMZq>; Mon, 17 Sep 2001 08:25:46 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45324 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273588AbRIQMZh>; Mon, 17 Sep 2001 08:25:37 -0400
Subject: Re: PROBLEM: [1.] X session randomly crashes because of kernel problem.
To: stephane.brossier@sun.com (Stephane Brossier)
Date: Mon, 17 Sep 2001 13:30:41 +0100 (BST)
Cc: linux-kernel@vger.kernel.org,
        Stephane.Brossier@sun.com (Stephane Brossier)
In-Reply-To: <3BA56490.FD898C70@sun.com> from "Stephane Brossier" at Sep 16, 2001 07:48:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ixXt-000738-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [2.] I installed the standart version of Mandrake8.0,
>      and I am working under kde2.1.1 with Xfree86 4.0.3.
> 
>      Suddenly my X session exits. Looking at the syslog
>      I can see the following log:

Can you duplicate the problem with a more recent kernel, and also 
preferably one without the supermount patch ?

Also does the machine past memtest86 ?
