Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285229AbSBZWqK>; Tue, 26 Feb 2002 17:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285720AbSBZWpV>; Tue, 26 Feb 2002 17:45:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16134 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285369AbSBZWpD>; Tue, 26 Feb 2002 17:45:03 -0500
Subject: Re: Congrats Marcelo,
To: lord@sgi.com (Steve Lord)
Date: Tue, 26 Feb 2002 22:59:34 +0000 (GMT)
Cc: adilger@turbolabs.com (Andreas Dilger),
        jdennis@snapserver.com (Dennis Jim),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <1014760581.5993.159.camel@jen.americas.sgi.com> from "Steve Lord" at Feb 26, 2002 03:56:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fqZK-0002NE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Someone has got to kill this assumption people have about XFS, it
> makes much smaller changes than some things which have gone in,
> the odd VM rewrite here and there to name some. Given that we now

Which was a complete disaster. IBM submitted Jfs into the -ac tree with
no lines of code changed outside fs/jfs. That is really the benchmark. 
