Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263419AbUEKTTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263419AbUEKTTj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 15:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUEKTTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 15:19:38 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:58891 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263419AbUEKTTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 15:19:38 -0400
Date: Tue, 11 May 2004 20:19:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: marcus hall <marcus@tuells.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Block device swamping disk cache
Message-ID: <20040511201936.A19384@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	marcus hall <marcus@tuells.org>, linux-kernel@vger.kernel.org
References: <20040511191124.GA16014@bastille.tuells.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040511191124.GA16014@bastille.tuells.org>; from marcus@tuells.org on Tue, May 11, 2004 at 01:11:24PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 01:11:24PM -0600, marcus hall wrote:
> I am having problems writing a filesystem image to a device file.
> 
> I am running an arm version of the 2.5.59 kernel.

I don't think anyone here still remembers stoneage-aera kernels.

You're better off trying to reproduce it with 2.6.6 I guess.

