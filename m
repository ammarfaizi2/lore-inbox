Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVBOMOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVBOMOQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 07:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVBOMOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 07:14:16 -0500
Received: from mx2.mail.ru ([194.67.23.122]:8759 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S261698AbVBOMNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 07:13:00 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [PATCH] procfs: Fix sparse warnings
Date: Tue, 15 Feb 2005 15:12:37 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200502151455.55711.adobriyan@mail.ru> <20050215115934.GK8859@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050215115934.GK8859@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200502151512.37774.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 February 2005 13:59, Al Viro wrote:
> On Tue, Feb 15, 2005 at 02:55:55PM +0200, Alexey Dobriyan wrote:
> 
> Let's hold this kind of stuff until 2.6.11, OK?
> 
> 	Al, sitting on more than a megabyte of such patches...

Could you send diffstat or something? I did "make allyesconfig" with
-Wbitwise and digging slowly from the beginning. Now at fs/qnx4.

	Alexey
