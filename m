Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261395AbREQKa6>; Thu, 17 May 2001 06:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261397AbREQKas>; Thu, 17 May 2001 06:30:48 -0400
Received: from gate1.rzeczpospolita.pl ([195.8.129.1]:32776 "EHLO
	rzeczpospolita.pl") by vger.kernel.org with ESMTP
	id <S261395AbREQKal>; Thu, 17 May 2001 06:30:41 -0400
Message-ID: <3B03A835.3DD48BDC@rzeczpospolita.pl>
Date: Thu, 17 May 2001 12:30:13 +0200
From: ps <ps@rzeczpospolita.pl>
X-Mailer: Mozilla 4.08 [en] (Win98; I)
MIME-Version: 1.0
To: Pim Zandbergen <P.Zandbergen@macroscoop.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: RH 7.1 on IBM xSeries 240
In-Reply-To: <fa.fhhq4kv.gguq9t@ifi.uio.no> <fa.fuo78ov.ikad9g@ifi.uio.no> <t977gtcpq17r85vlggngi9mk3a1k6qt01u@4ax.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pim Zandbergen wrote:
> 
> >Yes, I have the newest BIOS and SR Firmware.
> >I have 2 x 1GHz CPUs and IBM PCI ServeRAID 4.71.00  <ServeRAID 4L>
> 
> You mean all of BIOS, firmware and Linux driver are at version 4.71?
> 
> Where did you find BIOS 4.71 and firmware 4.71?
> The latest BIOS & firmware I could find is 4.50.

Firmware is 4.70.17, I'v got it directly from IBM engineer.
Previous firmware (2 days ago) was really 4.50 but it performed worse
(was less stable in performance).

> There is, however a driver version 4.72 in the latest 2.4.4-ac
> kernels.

I've tried it but it was all the same - I came back to 4.71
