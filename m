Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbTJVOCd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 10:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263681AbTJVOCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 10:02:33 -0400
Received: from ida.rowland.org ([192.131.102.52]:1796 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S263464AbTJVOCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 10:02:32 -0400
Date: Wed, 22 Oct 2003 10:02:32 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Pedro Larroy <piotr@member.fsf.org>
cc: linux-usb-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] aborts in usb-storage in branch 2.6
In-Reply-To: <20031022021028.GA4454@81.38.200.176>
Message-ID: <Pine.LNX.4.44L0.0310221001380.1050-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Oct 2003, Pedro Larroy wrote:

> Hi
> 
> 
> I experience aborts with external usb hd, that also pause all disk
> operations for some seconds.
> 
> It doesn't happen with 2.4.21 kernel.
> 
> Please tell me if I can do anything useful to debug the problem. I can use
> kgdb or other techniques.
> 
> It's getting very annoying since the disk stays for more than 10 seconds
> without responding.

Can you send more of the debugging log?  The portion you included didn't 
contain any context, making it hard to judge what the problem was.

Alan Stern

