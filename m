Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbVIEQUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbVIEQUk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 12:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbVIEQUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 12:20:40 -0400
Received: from [81.2.110.250] ([81.2.110.250]:59804 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750717AbVIEQUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 12:20:39 -0400
Subject: Re: linux-2.6.13-mm1 fails to build
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <431BFF11.5010306@ums.usu.ru>
References: <431BFF11.5010306@ums.usu.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 05 Sep 2005 13:23:54 +0100
Message-Id: <1125923034.8714.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-09-05 at 14:17 +0600, Alexander E. Patrakov wrote:
> Hello,
> 
> I tried to build linux-2.6.13-mm1 with the attached configuration, and 
> it failed with:
> 
> drivers/usb/serial/whiteheat.c: In function `rx_data_softint':
> drivers/usb/serial/whiteheat.c:1433: error: structure has no member 
> named `flip'


No that one hadn't. I'll see what I can do. Do you have hardware to test
changes ?

