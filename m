Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbTEHXDh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 19:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbTEHXDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 19:03:36 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:60809
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262217AbTEHXDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 19:03:35 -0400
Subject: Re: 2.5.69: VIA IDE still broken
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030508220910.GA1070@codeblau.de>
References: <20030508220910.GA1070@codeblau.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052432253.13550.37.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 May 2003 23:17:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-08 at 23:09, Felix von Leitner wrote:
> hardware with 2.4.* or 2.5.63.  I reported this before and got the
> answer that to fix this, recent changes in the IDE code would have to be
> reverted.  Apparently I was unreasonably hasty in assuming that that
> would be done now that the need to do it has been established.

Except that the change that triggers this seems correct, so until
someone explains the problem it won't.

> that.  Even the CPU appears to run too hot with Linux, causing the
> system to boot spontaneously under load, 

Sounds like your hardware is faulty. 


