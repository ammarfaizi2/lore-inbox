Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbVK1A5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbVK1A5r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 19:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbVK1A5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 19:57:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14998 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751198AbVK1A5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 19:57:47 -0500
Date: Sun, 27 Nov 2005 16:57:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tarkan Erimer <tarkane@gmail.com>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG]: Software compiling occasionlly hangs under
 2.6.15-rc1/rc2 and 2.6.15-rc1-mm2
Message-Id: <20051127165733.643d5444.akpm@osdl.org>
In-Reply-To: <9611fa230511271108m46389ee6w7ec6b5b40b1e23dd@mail.gmail.com>
References: <9611fa230511250312i55d0b872x82b8c33b4d2973e4@mail.gmail.com>
	<1132917564.7068.41.camel@laptopd505.fenrus.org>
	<9611fa230511270317led5b915h7daae3ef1287f86d@mail.gmail.com>
	<1133092701.2853.0.camel@laptopd505.fenrus.org>
	<9611fa230511271108m46389ee6w7ec6b5b40b1e23dd@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tarkan Erimer <tarkane@gmail.com> wrote:
>
>  My syslog and lsmod output attached

XFS went nuts.  Please test the latest git snapshot which has fixes for
this.
