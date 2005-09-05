Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbVIEWnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbVIEWnL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 18:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbVIEWnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 18:43:11 -0400
Received: from mail.europlex.ie ([83.141.76.10]:5733 "EHLO
	eurodubx.europlex.local") by vger.kernel.org with ESMTP
	id S964894AbVIEWnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 18:43:10 -0400
Message-ID: <431CCD39.2040905@eircom.net>
Date: Mon, 05 Sep 2005 23:56:57 +0100
From: "Bryan O'Donoghue" <typedef@eircom.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Change behaviour of psmouse-base.c under error conditions.
References: <431CB166.40904@eircom.net> <200509051612.14180.dtor_core@ameritech.net> <20050905215512.GB12252@midnight.suse.cz>
In-Reply-To: <20050905215512.GB12252@midnight.suse.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Sep 2005 22:46:24.0000 (UTC) FILETIME=[A4706000:01C5B26B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

>>Not all mice folow the protocol unfortunately. PLease try instead the
>>patch below


Yes Dmitry, that does as advertised.


Bryan
