Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265538AbTF3RoD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 13:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265564AbTF3RoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 13:44:03 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:37775
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265538AbTF3RoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 13:44:01 -0400
Subject: Re: PTY DOS vulnerability?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Fredrik Tolf <fredrik@dolda2000.cjb.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200306301613.11711.fredrik@dolda2000.cjb.net>
References: <200306301613.11711.fredrik@dolda2000.cjb.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056995729.17590.19.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Jun 2003 18:55:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-06-30 at 15:18, Fredrik Tolf wrote:
> Shouldn't PTYs be a per-user resource limit?

It depends to what degree you consider your users hostile. But yes its
possibly one of the things to do per user counting on.



