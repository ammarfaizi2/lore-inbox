Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263356AbTLOHsK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 02:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbTLOHsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 02:48:10 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:64783 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263356AbTLOHsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 02:48:08 -0500
Date: Mon, 15 Dec 2003 07:48:07 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: PCI Express support for 2.4 kernel
Message-ID: <20031215074807.B5441@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <3FDC9DC5.2070302@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FDC9DC5.2070302@intel.com>; from vladimir.kondratiev@intel.com on Sun, Dec 14, 2003 at 07:28:37PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 14, 2003 at 07:28:37PM +0200, Vladimir Kondratiev wrote:
> Hi,
> PCI-Express platforms will soon appear on the market. It is worth to 
> support it.
> 
> Following is patch for 2.4.23 kernel. I tested it on my host, it works 
> properly.
> I did it for i386 only, I have no other architecture to test.

Patch looks okay (except for totally broken indentation, that needs fixing)

It should go into 2.6 first. though.  And while you're at it add your
copyright info to the top of the file instead of the middle.

