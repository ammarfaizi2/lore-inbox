Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbTFZVIf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 17:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbTFZVIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 17:08:35 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:34947
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262601AbTFZVIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 17:08:32 -0400
Subject: Re: Serial ATA driver for 2.4.18.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adarsh Daheriya <AdarshDNet@netscape.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EFAABAD.1030809@netscape.net>
References: <3EFAABAD.1030809@netscape.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056662149.3174.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Jun 2003 22:15:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-06-26 at 09:15, Adarsh Daheriya wrote:
> hi all,
> 
> can anybody tell me where i can get the siimage SATA driver for 2.4.18 
> kernel?

The current one depends on the 2.4.20/2.4.21 IDE rework. I have no plans
to backport it although if you desperately need it you could I guess pay
someone

