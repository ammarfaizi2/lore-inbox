Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVDEHkC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVDEHkC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 03:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVDEHiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 03:38:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26844 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261602AbVDEHg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:36:27 -0400
Date: Tue, 5 Apr 2005 08:35:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Steve French <smfrench@austin.rr.com>, Steven French <sfrench@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] cifs: cleanup asn1.c
Message-ID: <20050405073559.GC26208@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jesper Juhl <juhl-lkml@dif.dk>,
	Steve French <smfrench@austin.rr.com>,
	Steven French <sfrench@us.ibm.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0504042254540.2496@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504042254540.2496@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 10:59:32PM +0200, Jesper Juhl wrote:
> 
> Hi Steve,
> 
> More fs/cifs/ cleanups for you. This time for asn1.c

Btw, shouldn't asn1.c move to lib/?

