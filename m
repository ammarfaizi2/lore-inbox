Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129273AbRBSVTu>; Mon, 19 Feb 2001 16:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129643AbRBSVTk>; Mon, 19 Feb 2001 16:19:40 -0500
Received: from t2o61p25.telia.com ([195.67.228.85]:9255 "EHLO k-7.stesmi.com")
	by vger.kernel.org with ESMTP id <S129273AbRBSVTa>;
	Mon, 19 Feb 2001 16:19:30 -0500
Message-ID: <3A918EAE.A3C96B4C@hanse.com>
Date: Mon, 19 Feb 2001 22:22:54 +0100
From: Stefan Smietanowski <stefan@hanse.com>
Organization: Hanse Communication
X-Mailer: Mozilla 4.75 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Ansari <mike@khi.sdnpk.org>, linux-kernel@vger.kernel.org
Subject: [OT] Re: Running Bind 9 on Redhat 7
In-Reply-To: <3A913520.3011C7D6@khi.sdnpk.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> I am configuring Bind 9 on Redhat 7 but unable to start the named.
> Here is my /var/log message log:

<snip named start log>

Read the documentation and you shall notice that you must set a ttl for
each zone, which also your logs state that you have not done ...

// Stefan
