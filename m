Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264405AbTL3Eek (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 23:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264441AbTL3Eek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 23:34:40 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:54199 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264405AbTL3Eeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 23:34:37 -0500
Date: Mon, 29 Dec 2003 10:36:01 -0500
From: Willem Riede <wrlk@riede.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add "simple" class device support  [1/5]
Message-ID: <20031229153601.GY1277@linnie.riede.org>
Reply-To: wrlk@riede.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

+ * Note: the struct class passed to this function must have previously been
+ * registered with a call to register_class().

Would that be class_register()?

Thanks, Willem Riede.
