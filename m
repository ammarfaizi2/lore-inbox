Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275216AbTHGIAd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 04:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275218AbTHGIAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 04:00:32 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:11782 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S275216AbTHGIAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 04:00:32 -0400
Date: Thu, 7 Aug 2003 09:00:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test2-mm5
Message-ID: <20030807090031.A12476@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030806223716.26af3255.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030806223716.26af3255.akpm@osdl.org>; from akpm@osdl.org on Wed, Aug 06, 2003 at 10:37:16PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 10:37:16PM -0700, Andrew Morton wrote:
> +devfs-pty-slave-fix.patch
> 
>  devfs fix

This patch is wrong.  Those nodes are managed by devpts.

