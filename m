Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbVDOVJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbVDOVJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 17:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVDOVJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 17:09:58 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:62894 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261971AbVDOVJ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 17:09:57 -0400
Subject: Re: [PATCH] tpm: fix gcc printk warnings
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <42361B38.4060704@osdl.org>
References: <20050314145522.787a6865.rddunlap@osdl.org>
	 <20050314150825.5f52b1a8.akpm@osdl.org>  <42361B38.4060704@osdl.org>
Content-Type: text/plain
Date: Fri, 15 Apr 2005 16:09:32 -0500
Message-Id: <1113599372.4573.79.camel@dyn95395164>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch that was attached to this orginal message looks good to me and
can be applied to the Tpm driver.

Thanks,
Kylie

On Mon, 2005-03-14 at 15:16 -0800, Randy.Dunlap wrote:
> Andrew Morton wrote:
> > "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> > 
> > Nope.  Please use %Z for size_t args.
> 
> Yeps.  Here it is.
> 

