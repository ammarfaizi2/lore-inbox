Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbTEEWbd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 18:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbTEEWbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 18:31:33 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:47792 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261446AbTEEWbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 18:31:32 -0400
Subject: Re: 2.5.69-mm1 OOPS: modprobe usbcore
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030505165059.GA1199@kroah.com>
References: <1052151088.1052.0.camel@teapot.felipe-alfaro.com>
	 <20030505165059.GA1199@kroah.com>
Content-Type: text/plain
Message-Id: <1052174634.603.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2.99 (Preview Release)
Date: 06 May 2003 00:43:54 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-05 at 18:51, Greg KH wrote:
> On Mon, May 05, 2003 at 06:11:28PM +0200, Felipe Alfaro Solana wrote:
> > 
> > This error is reproducble 100% of the time when trying to boot Red Hat
> > Linux 9 with a 2.5.69-mm1 kernel. Config attached.
> 
> Same thing happen on 2.5.69 (no mm)?

No... Vanilla 2.5.69 works fine.

-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

