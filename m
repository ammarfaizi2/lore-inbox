Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbUJ1Qwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbUJ1Qwn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 12:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbUJ1Qwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 12:52:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23968 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261741AbUJ1Qwk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 12:52:40 -0400
Date: Thu, 28 Oct 2004 17:52:39 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Alessandro Amici <lists@b-open-solutions.it>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: massive cross-builds without too much PITA
Message-ID: <20041028165239.GS24336@parcelfarce.linux.theplanet.co.uk>
References: <20041028054833.GP24336@parcelfarce.linux.theplanet.co.uk> <200410281821.22486.lists@b-open-solutions.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410281821.22486.lists@b-open-solutions.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 06:21:22PM +0200, Alessandro Amici wrote:
> The package toolchain-source (together with dpkg-cross) makes the process even 
> more automatic.

gcc and binutils in there tend to get out of sync with native ones.  Which
is a killer, as far as I'm concerned...
