Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262810AbUDTMv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbUDTMv7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 08:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUDTMv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 08:51:59 -0400
Received: from mail.cyclades.com ([64.186.161.6]:59350 "EHLO mail.cyclades.com")
	by vger.kernel.org with ESMTP id S262810AbUDTMv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 08:51:57 -0400
Date: Tue, 20 Apr 2004 09:53:08 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: ann_pearlstein@mysunrise.ch
Cc: linux-kernel@vger.kernel.org
Subject: Re: libata and the 2.4 kernel
Message-ID: <20040420125308.GB12478@logos.cnet>
References: <11962398.1082463710160.JavaMail.tomcat4@webmail-be-05.sunrise.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11962398.1082463710160.JavaMail.tomcat4@webmail-be-05.sunrise.ch>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2004 at 02:21:50PM +0200, ann_pearlstein@mysunrise.ch wrote:
> Hello,
> 
> Does anyone know when (or even if) the libata patch will be native to the 2.4 kernel (e.g., no patch needed)?  
> 
> If there are plans to add it to the 2.4 kernel, when (approximately :-)  ) will it be a part of this kernel?
> 
> I know it's supported natively in the 2.6 kernel.
> 
> The libata patch (2.4.25 kernel and 2.4.25 libata patch) works well for the serial ATA drive I use (in a Dell PowerEdge 750), but I'd like to have a non-patched kernel for this particular project.  
> 
> Thank you in advance for any and all info.

Ann, 

libata has been included in the 2.4 BK tree.

You can try 2.4.26-bk patches (www.kernel.org)
