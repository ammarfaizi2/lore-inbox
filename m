Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275227AbTHMMc0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 08:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275230AbTHMMcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 08:32:25 -0400
Received: from baloney.puettmann.net ([194.97.54.34]:33977 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S275227AbTHMMcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 08:32:16 -0400
Date: Wed, 13 Aug 2003 14:31:19 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.4.22 APM problems with IBM Thinkpad's
Message-ID: <20030813123119.GA25111@puettmann.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Ruben Puettmann <ruben@puettmann.net>
X-Scanner: exiscan *19mumd-0006bB-00*3Ea4xdVyvcY* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    hy,

cause many problems with acpi I try to get apm running on my ibm
thinkpad R40 ( 2722). But with 2.4.22-pre10 and 2.4.22-pre10-ac1.

Problems which happend:

apm -s don't work with radeonfb usb and so on see my mails on lkm the
last days

If CONFIG_APM_DISPLAY_BLANK is Y the thinkpad freezed on blanking the
display

If CONFIG_APM_REAL_MODE_POWER_OFF is Y or N te thinkpad never power off


        Ruben




-- 
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net
