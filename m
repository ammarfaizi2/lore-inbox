Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261494AbRERTmf>; Fri, 18 May 2001 15:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261497AbRERTmZ>; Fri, 18 May 2001 15:42:25 -0400
Received: from mail.ask.ne.jp ([203.179.96.3]:58602 "EHLO mail.ask.ne.jp")
	by vger.kernel.org with ESMTP id <S261494AbRERTmJ>;
	Fri, 18 May 2001 15:42:09 -0400
Date: Sat, 19 May 2001 04:42:10 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: Alex Deucher <agd5f@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DMA support for toshiba IDE controllers
Message-Id: <20010519044210.65d17656.bruce@ask.ne.jp>
In-Reply-To: <20010518181509.88522.qmail@web11301.mail.yahoo.com>
In-Reply-To: <20010518181509.88522.qmail@web11301.mail.yahoo.com>
X-Mailer: Sylpheed version 0.4.66 (GTK+ 1.2.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2001 11:15:09 -0700 (PDT)
Alex Deucher <agd5f@yahoo.com> wrote:

> Does anyone know if there is any DMA support for the
> toshiba IDE controller's in many of their portable
> models such as the older porteges and librettos?  The
> controllers support DMA, but not in linux.  I'm not
> sure what toshiba's policy is on documentation.  They
> used to be pretty stingy, but I heard they have
> recently opened up of lot of their doc's, like the
> oboe IR controller for instance. 


Well, Toshiba Japan has a Linux developers' page (in Japanese):

http://linux.toshiba-dme.co.jp/linux/jpn/develop.php3

According to that page, their mail address for requests from developers is:

linux@toshiba-dme.co.jp

so if you don't get any satisfaction from Toshiba USA/Europe/wherever you're
living, try asking Toshiba Japan (they do ask that you be specific, so if you
send them a request, make sure to state exactly which models/chipsets, etc.,
you're interested in, and remember that they might take a while to reply to
email in English). They do seem to be quite good lately about releasing
documentation - Dag Brattli got some info on the IrDA hardware they use, and
the Japan Linux Association has got docs for the ToPIC PC Card controller out
of them, too. The only time they've actually turned someone down (according to
that page, anyway) is when the hardware in question included third-party
technology.


Bruce


