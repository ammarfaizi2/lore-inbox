Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbTHSURj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 16:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbTHSURH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 16:17:07 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:10180 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S261384AbTHSUQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 16:16:43 -0400
Subject: Can't read fan-speeds from i2c
From: Stian Jordet <liste@jordet.nu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1061324213.708.6.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 19 Aug 2003 22:16:53 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a Asus CUV266-DLS, which uses the as99127f chipset. Everything
seems to work as it is supposed to, except for fan-speeds. They say 0.
Is that supposed behaviour since the as99127f doesn't have any
datasheets, or am I doing something wrong?

Best regards,
Stian

