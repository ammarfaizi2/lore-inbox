Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317193AbSFBO4Z>; Sun, 2 Jun 2002 10:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317195AbSFBO4Y>; Sun, 2 Jun 2002 10:56:24 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:58361 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317194AbSFBO4Y>; Sun, 2 Jun 2002 10:56:24 -0400
Subject: Re: FUD or FACTS ?? but a new FLAME!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.30.0206021621050.7413-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 02 Jun 2002 17:00:48 +0100
Message-Id: <1023033648.23874.39.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-06-02 at 15:25, Bartlomiej Zolnierkiewicz wrote:
> Please explain further, so in general AMD, Intel must not be overclocked?
> Beacause if they are they are screwed (not only IDE)...?

You can start with the fact that they are not engineered to run at other
speeds. In addition these are the base chipset for machines, they aren't
add in cards that are stuck onto existing broken socket 7 systems with
75/83.33Mhz FSB. 

They are specced for 33Mhz only. 
