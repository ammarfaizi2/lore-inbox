Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbUBYQSM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 11:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbUBYQRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 11:17:23 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:8978 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261387AbUBYQOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 11:14:44 -0500
Date: Wed, 25 Feb 2004 16:14:41 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jakub Bogusz <qboosh@pld-linux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i2c on alpha - used but not available in 2.6.3
Message-ID: <20040225161441.A6161@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jakub Bogusz <qboosh@pld-linux.org>, linux-kernel@vger.kernel.org
References: <20040225160833.GA5803@gruby.cs.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040225160833.GA5803@gruby.cs.net.pl>; from qboosh@pld-linux.org on Wed, Feb 25, 2004 at 05:08:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 05:08:33PM +0100, Jakub Bogusz wrote:
> I checked that adding including of drivers/i2c/Kconfig to arch/alpha/Kconfig
> everything build and all remaining unresolved symbols fade away.

I'd just switch alpha to use drivers/Kconfig

