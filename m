Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263897AbTD0KWj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 06:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263912AbTD0KWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 06:22:37 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:46341 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263897AbTD0KWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 06:22:36 -0400
Date: Sun, 27 Apr 2003 10:02:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Willy TARREAU <willy@w.ods.org>
Cc: marcelo@conectiva.com.br, vandrove@vc.cvut.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.4] was: Matrox FB problem in latest 2.4.21-rc1-BK
Message-ID: <20030427100200.A26804@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Willy TARREAU <willy@w.ods.org>, marcelo@conectiva.com.br,
	vandrove@vc.cvut.cz, linux-kernel@vger.kernel.org
References: <20030427083232.GA171@pcw.home.local> <20030427085711.GA181@pcw.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030427085711.GA181@pcw.home.local>; from willy@w.ods.org on Sun, Apr 27, 2003 at 10:57:11AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 27, 2003 at 10:57:11AM +0200, Willy TARREAU wrote:
> Hi again,
> 
> OK I found it to be a typo in cset-1.1134 (intel fb fixes) which disabled CFB8.
> It now works with this patch. Christoph, you might also have the typo in your
> tree.

Yes, sorry for the typo.

