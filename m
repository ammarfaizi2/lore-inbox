Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261472AbTCYGcK>; Tue, 25 Mar 2003 01:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261474AbTCYGcK>; Tue, 25 Mar 2003 01:32:10 -0500
Received: from rth.ninka.net ([216.101.162.244]:4032 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S261472AbTCYGcJ>;
	Tue, 25 Mar 2003 01:32:09 -0500
Subject: Re: stray 2.4 tcp fix.
From: "David S. Miller" <davem@redhat.com>
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200303241642.h2OGgC35008344@deviant.impure.org.uk>
References: <200303241642.h2OGgC35008344@deviant.impure.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048574595.8067.1.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 24 Mar 2003 22:43:15 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-24 at 08:42, davej@codemonkey.org.uk wrote:
> Sent to davem and netdev already, and was met with silence..

Thanks for finding this I'll apply it, but please note:

1) I am a lossy protocol like IP, so you may need to retransmit
   a patch if I don't respond to it.

2) For some reason a lot of netdev mails aren't making their
   way to me, I believe I've been unsubscribed and I'll check
   this now.

Thanks again.

-- 
David S. Miller <davem@redhat.com>
