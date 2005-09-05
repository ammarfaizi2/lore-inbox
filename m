Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932603AbVIEVcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbVIEVcT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbVIEVcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:32:18 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:52530 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932597AbVIEVcQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:32:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=SOcSvY60VdhYDcvkREIVdp7DQ5JP8fTvuPn4S4f1zctexOHzrhUTPPUHY8nLfcWEbMT327LfOQ+3cBhpQPaQzVg9TJy+hwjipbTXZZJW7EwimWApkbNfd6kPabJX4KLPORrZriwQ3YcjAtqsniD8bh6zbRef0K/s/lYRzpKpMEY=
Date: Mon, 5 Sep 2005 23:31:19 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: #4998 - Re: kernel status, 5 Sep 2005
Message-Id: <20050905233119.b1975f77.diegocg@gmail.com>
In-Reply-To: <20050905135546.7732ec27.akpm@osdl.org>
References: <20050905135546.7732ec27.akpm@osdl.org>
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.2; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 5 Sep 2005 13:55:46 -0700,
Andrew Morton <akpm@osdl.org> escribió:

>   Tracking 144 bugs.  I haven't culled these yet - some may be fixed.

[...]

> [Bugme-new] [Bug 4998] New: "init 0" broken between 2.6.12 and
> 	http://bugzilla.kernel.org/show_bug.cgi?id=4998

Fixed in 2.6.13.rc5-git4 according with the reporter
