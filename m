Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266200AbUIVQG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266200AbUIVQG4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 12:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266193AbUIVQGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 12:06:55 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:17168 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266189AbUIVQGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 12:06:53 -0400
Date: Wed, 22 Sep 2004 17:06:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Rodrigo Severo <rodrigo.lists@fabricadeideias.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: SCSI Initio 9100UW (INIC-950p chipset) support nunder kernel 2.6.x
Message-ID: <20040922170651.A3340@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rodrigo Severo <rodrigo.lists@fabricadeideias.com>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <4151A24A.7000302@fabricadeideias.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4151A24A.7000302@fabricadeideias.com>; from rodrigo.lists@fabricadeideias.com on Wed, Sep 22, 2004 at 01:03:00PM -0300
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2004 at 01:03:00PM -0300, Rodrigo Severo wrote:
> with kernel 2.4.24 (yes, I know it's old).
> 
> I want to update my kernel do 2.6.8. The question: is there support for 
> this board/chipset under kernel 2.6.x?
> 
> I looked around a lot and couldn't find much. www.initio.com says their 
> code is in the kernel since 2.0.32. Has it been left out for 2.6.x?
> 
> Is anyone working on this port? Anyone intending to work on it?

The driver still exists and actually compiles.  It's marked BROKEN, although
I don't know why.  If you want to help testing we can update it to current
standards.

