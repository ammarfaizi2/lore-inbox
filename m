Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbTDWTWe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264455AbTDWTUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:20:50 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:22201 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264450AbTDWTUq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:20:46 -0400
Date: Wed, 23 Apr 2003 12:34:38 -0700
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB speedtouch: crc optimization
Message-ID: <20030423193438.GB12674@kroah.com>
References: <200304231050.53630.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304231050.53630.baldrick@wanadoo.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 10:50:53AM +0200, Duncan Sands wrote:
>  speedtch.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

greg k-h
