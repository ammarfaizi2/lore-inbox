Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262795AbVAFJ3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbVAFJ3x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 04:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbVAFJ3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 04:29:52 -0500
Received: from [213.146.154.40] ([213.146.154.40]:45987 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262795AbVAFJ27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 04:28:59 -0500
Date: Thu, 6 Jan 2005 09:28:58 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Harald Dunkel <harald@CoWare.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10: "[permanent]" modules?
Message-ID: <20050106092858.GB15162@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Harald Dunkel <harald@CoWare.com>, linux-kernel@vger.kernel.org
References: <41DCE48E.5010604@coware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DCE48E.5010604@coware.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 08:11:10AM +0100, Harald Dunkel wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi folks,
> 
> Seems that for 2.6.10 I cannot unload ide modules.
> 'lsmod | grep permanent" lists

...

> Is this on purpose?

Yes.

