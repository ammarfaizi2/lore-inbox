Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbTL3Eb2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 23:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbTL3Eb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 23:31:28 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:32396 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S264368AbTL3Eb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 23:31:27 -0500
Date: Mon, 29 Dec 2003 22:04:32 -0500
From: Willem Riede <wrlk@riede.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add "simple" class device support  [1/5]
Message-ID: <20031230030432.GO1277@linnie.riede.org>
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
