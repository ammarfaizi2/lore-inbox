Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbTELNCR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 09:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbTELNCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 09:02:17 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:57495
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262118AbTELNCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 09:02:16 -0400
Subject: Re: MPPE in kernel?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Frank Cusack <fcusack@fcusack.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, paulus@samba.org
In-Reply-To: <20030512045929.C29781@google.com>
References: <20030512045929.C29781@google.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052741786.31246.30.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 May 2003 13:16:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-05-12 at 12:59, Frank Cusack wrote:
> For 2.5.x, just the arcfour code is needed (since sha1 is already there).
> I've written a public domain implementation, which I'd be willing to
> relicense under GPL (although I don't see the point), but in any case
> the algorithm is easy and could be written by anyone.

Public domain is GPL compatible anyway so it doesnt matter if its
"merely" public domain. 
