Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTLSKYs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 05:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbTLSKYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 05:24:48 -0500
Received: from csbd.org ([66.220.23.20]:3233 "EHLO csbd.org")
	by vger.kernel.org with ESMTP id S262288AbTLSKYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 05:24:47 -0500
To: wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 fails to complete boot - Sony VAIO laptop
Date: Fri Dec 19 02:18:06 2003
Content-Type: text/plain; charset="utf8"
Content-Transfer-Encoding: 7bit
Message-Id: <20031219101806.9CD491E030CA3@csbd.org>
From: atp@csbd.org (Alexander Poquet)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Dec 2003 02:16:27 -0800, William Lee Irwin III wrote:
> Okay, nothing matching other bugreports turned up here. I might have
> to ask you to try to capture some log information. Do you have a null
> modem cable or a null modem adapter and serial cable, and another box
> to hook that up to?

Unfortunately not.  Is there any other way I might capture some output?  I 
was thinking I might be able to install a null loop a la while( 1 ) { } 
somewhere before filesystems are mounted, and then move it down until 
the blank out occurs.  What do you think?  Could you point me to a relevant
place in the boot process that I could do this?  Would it even help?

Alexander 
