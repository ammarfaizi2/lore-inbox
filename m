Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264828AbUD1PCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264828AbUD1PCT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 11:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264837AbUD1PCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 11:02:19 -0400
Received: from mail.native-instruments.de ([217.9.41.138]:3814 "EHLO
	mail.native-instruments.de") by vger.kernel.org with ESMTP
	id S264828AbUD1PBh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 11:01:37 -0400
From: Florian Schirmer <florian.schirmer@native-instruments.de>
Organization: NATIVE INSTRUMENTS Software Synthesis GmbH
To: stefan.eletzhofer@eletztrick.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add RTC 8564 I2C chip support
Date: Wed, 28 Apr 2004 17:01:26 +0200
User-Agent: KMail/1.6.2
References: <20040428134122.GB23076@gonzo.local>
In-Reply-To: <20040428134122.GB23076@gonzo.local>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404281701.26851.florian.schirmer@native-instruments.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

FYI alle deine Mails kommen immer 2x auf der LKML an. Solltest du mal bei 
Gelegenheit untersuchen. Mir ists egal aber es gibt immer ein paar Dödel die 
dann nichts besseres zu tun haben als sich zu Ärgern ;-)

Grüsse,
   Florian

On Wednesday 28 April 2004 15:41, stefan.eletzhofer@eletztrick.de wrote:
> Hi,
> the attached patch adds support for the Epson 8564 RTC
> chip. This chip is a generic real-time-clock sitting on
> a I2C bus.
>
> Patch URL:
> http://213.239.196.168/~seletz/patches/2.6.6-rc2/i2c-rtc8564.patch
>
> Please comment,
> 	Stefan E.
