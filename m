Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266880AbUHYLYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266880AbUHYLYg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 07:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266884AbUHYLYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 07:24:35 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:39689 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266880AbUHYLYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 07:24:34 -0400
Date: Wed, 25 Aug 2004 12:24:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question regardig mount --bind option.
Message-ID: <20040825122428.A7478@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Justin Piszcz <jpiszcz@lucidpixels.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0408250707590.20397@p500>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.61.0408250707590.20397@p500>; from jpiszcz@lucidpixels.com on Wed, Aug 25, 2004 at 07:11:06AM -0400
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 07:11:06AM -0400, Justin Piszcz wrote:
> Is there any performance hit either with latency or bandwidth when using 
> the detination path of a mount --bind option?
> 
> example:
> 
> # /ide/disk1
> # mount --bind /ide/disk1 /home
> 
> Would /home be any slower than directly accessing /ide/disk1?

no

