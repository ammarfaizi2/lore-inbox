Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264933AbUEQL1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbUEQL1X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 07:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264948AbUEQL1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 07:27:23 -0400
Received: from imap.gmx.net ([213.165.64.20]:10184 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264933AbUEQL1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 07:27:22 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: problem with sis900
Date: Mon, 17 May 2004 13:35:26 +0200
User-Agent: KMail/1.6.2
References: <1084300104.24569.8.camel@datacontrol> <200405132002.56402.dominik.karall@gmx.net> <20040515071233.GB9289@picchio.gall.it>
In-Reply-To: <20040515071233.GB9289@picchio.gall.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200405171335.26513.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 May 2004 09:12, Daniele Venzano wrote:
> On Thu, May 13, 2004 at 08:02:56PM +0200, Dominik Karall wrote:
> > Sorry, but the patch does not help, same error messages in log, and can't
> > change to full-duplex mode.
>
> My fault, the linked list gets filled in reverse, address 1 is at the
> end.
>
> With the attached patch I should got it right...

Just for info to the list, this patch works and I can use the card in 
full-duplex mode now.

Thanks!

greets dominik
