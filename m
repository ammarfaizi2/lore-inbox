Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271978AbRJJBQH>; Tue, 9 Oct 2001 21:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272549AbRJJBP5>; Tue, 9 Oct 2001 21:15:57 -0400
Received: from sushi.toad.net ([162.33.130.105]:41388 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S271995AbRJJBPl>;
	Tue, 9 Oct 2001 21:15:41 -0400
Subject: Re: Linux 2.4.10-ac10
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: bunk@fs.tum.de
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 09 Oct 2001 21:15:43 -0400
Message-Id: <1002676545.5283.4.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Two things that might perhaps have influence:
> 2.4.10-ac9
> ...
> o   Clean up ad1816 resource handling     (Arnaldo Carvalho de Melo)
> ...

I think you've got it.


> How does PnPBIOS work together with CONFIG_ISAPNP in the kernel?

They don't.

I don't think PnPBIOS is the cause of your problem.

--
Thomas





