Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266609AbUH0Qxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266609AbUH0Qxw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 12:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266604AbUH0Qxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 12:53:52 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:1803 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266609AbUH0Qvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 12:51:42 -0400
Date: Fri, 27 Aug 2004 17:51:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Kenneth Lavrsen <kenneth@lavrsen.dk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6.8 pwc patches and counterpatches
Message-ID: <20040827175136.A818@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kenneth Lavrsen <kenneth@lavrsen.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <6.1.2.0.2.20040827171755.01c1f328@inet.uni2.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <6.1.2.0.2.20040827171755.01c1f328@inet.uni2.dk>; from kenneth@lavrsen.dk on Fri, Aug 27, 2004 at 06:26:14PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 06:26:14PM +0200, Kenneth Lavrsen wrote:
> When Greg decided to remove the hook that enabled the use of pwcx HE 
> decided to remove the driver. In practical the pwc driver is worthless 
> without pwc. Completely worthless. The tiny picture size supported without 

Then the kerneltree is indeed the wrong place for it.

