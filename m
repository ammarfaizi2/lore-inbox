Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276249AbRKOL7v>; Thu, 15 Nov 2001 06:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280597AbRKOL7l>; Thu, 15 Nov 2001 06:59:41 -0500
Received: from marao.utad.pt ([193.136.40.3]:53511 "EHLO marao.utad.pt")
	by vger.kernel.org with ESMTP id <S276249AbRKOL7a>;
	Thu, 15 Nov 2001 06:59:30 -0500
Subject: Re: How to set speed for EEPro100 ?
From: Alvaro Lopes <alvieboy@alvie.com>
To: Marco Schwarz <mschwarz_contron@yahoo.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011115114301.51726.qmail@web10307.mail.yahoo.com>
In-Reply-To: <20011115114301.51726.qmail@web10307.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 15 Nov 2001 11:57:23 +0000
Message-Id: <1005825444.3016.0.camel@dwarf>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Use a simple tool called mii-diag
Download it at http://www.scyld.com/diag/index.html

On Qui, 2001-11-15 at 11:43, Marco Schwarz wrote:
> Hi,
> 
> I am having some problems with my EEPro 100 card.
> Seems like my dual speed hub doesnt like it when some
> of the cards are 10 MB and some others are 100 ....
> 
> How can I force the card to use 10 MB instead of 100MB
> or auto detect ? I am using the driver included in
> kernel 2.4.9, and I couldnt find any infos on how to
> do this ... 
> 
> Thanks in advance
> 
> Marco Schwarz
> 
> 
> __________________________________________________________________
> 
> Gesendet von Yahoo! Mail - http://mail.yahoo.de
> Ihre E-Mail noch individueller? - http://domains.yahoo.de
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


