Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264456AbTH2GG4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 02:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264457AbTH2GG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 02:06:56 -0400
Received: from angband.namesys.com ([212.16.7.85]:924 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S264456AbTH2GGz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 02:06:55 -0400
Date: Fri, 29 Aug 2003 10:06:53 +0400
From: Oleg Drokin <green@namesys.com>
To: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
Cc: jeffm@suse.com
Subject: Re: Reiserfs, xattr's and selinux
Message-ID: <20030829060653.GA6079@namesys.com>
References: <20030828204335.GE6898@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030828204335.GE6898@vnl.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Aug 28, 2003 at 09:43:35PM +0100, Dale Amon wrote:
> I understand someone may have a patch to let reiserfs work with
> selinux in the 2.6.0-test4 kernel. If so, where would I find it, 
> or who should I talk to about it?

SuSE does the work on that.
I do not know if they have 2.6 port, but they do have 2.4 working and they 
ship this code in their kernels.

Jeff Mahoney is correct person to ask. (jeffm@suse.com)

Bye,
    Oleg
