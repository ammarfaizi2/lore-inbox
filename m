Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbTFXRct (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 13:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbTFXRct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 13:32:49 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:26790 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262256AbTFXRcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 13:32:48 -0400
Date: Tue, 24 Jun 2003 10:40:41 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org,
       Eduardo Pereira Habkost <ehabkost@conectiva.com.br>
Subject: Re: [PATCH][2.5] Fix compilation of ip2main (fwd)
Message-ID: <20030624174041.GA12011@kroah.com>
References: <20030624173434.GU3710@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030624173434.GU3710@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 24, 2003 at 07:34:34PM +0200, Adrian Bunk wrote:
> Could anyone comment on this patch?
> 
> This patch by Eduardo Pereira Habkost <ehabkost@conectiva.com.br> or 
> something similar is still needed in 2.5.73 to fix the compilation of 
> ip2main.c .

Bleah, yeah, that's my fault.  I'll apply this and forward it on to
Linus.

Sorry about that.

greg k-h
