Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132292AbRA3TB3>; Tue, 30 Jan 2001 14:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132293AbRA3TBU>; Tue, 30 Jan 2001 14:01:20 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:33267
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S132292AbRA3TBF>; Tue, 30 Jan 2001 14:01:05 -0500
Date: Tue, 30 Jan 2001 11:59:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [UPDATE] Fresh zerocopy patch on kernel.org
Message-ID: <20010130115939.H17512@opus.bloom.county>
In-Reply-To: <14966.35438.429963.405587@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <14966.35438.429963.405587@pizda.ninka.net>; from davem@redhat.com on Tue, Jan 30, 2001 at 01:33:34AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2001 at 01:33:34AM -0800, David S. Miller wrote:

> Have fun testing...

I've got a question.  I think one of the threads mentioned that this could
help NFS performance, in general.  I assume having the NFS traffic go out
the a card w/ the right HW could help as well, right?  Should the 3com
3c905b work, and how can i check it's "working" ?  Thanks!

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
