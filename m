Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263937AbUECTcC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbUECTcC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 15:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263932AbUECTcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 15:32:02 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:48905 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263937AbUECTb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 15:31:58 -0400
Date: Mon, 3 May 2004 20:31:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.5.1
Message-ID: <20040503203156.A14171@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
	linux-kernel@vger.kernel.org
References: <200405030111.49802.mmazur@kernel.pl> <20040503194757.A13711@infradead.org> <40969C87.4060804@backtobasicsmgmt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40969C87.4060804@backtobasicsmgmt.com>; from kpfleming@backtobasicsmgmt.com on Mon, May 03, 2004 at 12:24:55PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 12:24:55PM -0700, Kevin P. Fleming wrote:
> Mariusz' headers work really well; there are people building complete 
> systems (X/KDE/GNOME/etc.) using them without any difficulties at this 
> point.

The thing is they're still conceptually wrong.  Glibc should provide working
and full-featured networking headers.

