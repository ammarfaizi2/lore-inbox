Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbUJ1A0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbUJ1A0U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 20:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262699AbUJ1AYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 20:24:08 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:8187 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262654AbUJ1ASu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 20:18:50 -0400
Date: Wed, 27 Oct 2004 17:18:43 -0700
From: Chris Wedgwood <cw@f00f.org>
To: haskellboy@ig.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Re: [question]- DMA
Message-ID: <20041028001843.GA2115@taniwha.stupidest.org>
References: <20041027_233143_086641.haskellboy@ig.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027_233143_086641.haskellboy@ig.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 08:31:43PM -0300, haskellboy@ig.com.br wrote:

> can DMA copy from RAM to hard disk?

yes

> if yes, the kernel uses DMA to copy from disk to disk?

no, the disk hardware that (almost all) linux hardware uses doesn't
allow this easily
