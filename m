Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264202AbUESR3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264202AbUESR3A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 13:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264471AbUESR3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 13:29:00 -0400
Received: from piggy.rz.tu-ilmenau.de ([141.24.4.8]:18589 "EHLO
	piggy.rz.tu-ilmenau.de") by vger.kernel.org with ESMTP
	id S264202AbUESR26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 13:28:58 -0400
Date: Wed, 19 May 2004 19:28:45 +0200
From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
To: Sebastian <sebastian@expires0604.datenknoten.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange DMA-errors and system hang with Promise 20268
Message-ID: <20040519172845.GA26122@darkside.22.kls.lan>
Mail-Followup-To: Mario 'BitKoenig' Holbe <Mario.Holbe@RZ.TU-Ilmenau.DE>,
	Sebastian <sebastian@expires0604.datenknoten.de>,
	linux-kernel@vger.kernel.org
References: <1078602426.16591.8.camel@vega> <c2dsha$psd$1@sea.gmane.org> <1084987258.4662.4.camel@coruscant.datenknoten.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084987258.4662.4.camel@coruscant.datenknoten.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 07:20:58PM +0200, Sebastian wrote:
> Same thing here. The machine crashes on weekends shortly after 01:00

WDC drives involved by accident (i.e. do you have any
WDC drive connected to your promise controller(s))?

> suggested, but too recently to be sure that it was the cause. It could
> just be related to additional load caused by cron jobs?

Yes.

> Any confirmed solutions yet?

Depends :) Not really.
Currently, I suspect it to be some Promise<->WDC issue,
thus it depends on your answer to my question :)


regards,
   Mario
-- 
Uebrigens... Wer frueher stirbt ist laenger tot!
