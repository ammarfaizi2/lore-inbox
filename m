Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbUFQT3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbUFQT3N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 15:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbUFQT3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 15:29:13 -0400
Received: from [213.146.154.40] ([213.146.154.40]:64688 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261939AbUFQT3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 15:29:04 -0400
Date: Thu, 17 Jun 2004 20:28:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove EXPORT_SYMBOL(kallsyms_lookup)
Message-ID: <20040617192859.GA5449@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Oleg Drokin <green@linuxhacker.ru>, greg@kroah.com,
	linux-kernel@vger.kernel.org
References: <20040617162927.GA12498@kroah.com> <200406171731.i5HHVA0M015051@car.linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406171731.i5HHVA0M015051@car.linuxhacker.ru>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 08:31:10PM +0300, Oleg Drokin wrote:
> user will find this later and will send a bugreport to developers?
> (yes, there are problems with simply doing dump_stack()).
> Or perhaps we need dump_stack version that will print the dump into a
> supplied buffer then?

Yes, please please please! ;-)

