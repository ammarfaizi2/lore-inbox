Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270676AbTHJUzR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 16:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270677AbTHJUzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 16:55:17 -0400
Received: from mail.gondor.com ([212.117.64.182]:8454 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S270676AbTHJUzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 16:55:14 -0400
Date: Sun, 10 Aug 2003 22:55:13 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uncorrectable ext2 errors
Message-ID: <20030810205513.GA6337@gondor.com>
References: <20030806150335.GA5430@gondor.com> <20030807110641.GA31809@gondor.com> <20030807211236.GA5637@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030807211236.GA5637@win.tue.nl>
X-Request-PGP: http://gondor.com/key.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 11:12:36PM +0200, Andries Brouwer wrote:
> Last September or so there was a long discussion about a
> filesystem that was destroyed. But what I recall is that
> in the end it turned out not to be a hardware problem,
> but a precedence problem - two missing parentheses in the driver.
> 
> Google will tell you all, I suppose. Search for Promise and Isely.

Yes, thanks, I found these mails, and they may describe exactly the 
symptoms I saw on my server. So perhaps the fixes have not been
(correctly) applied?

I only saw the mails from Mike Isely, but no 'official' response. Do you
remember if the patches got accepted by one of the maintainers? Andre?

Jan

