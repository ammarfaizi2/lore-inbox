Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264629AbTFELya (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 07:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264632AbTFELya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 07:54:30 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:63885 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264629AbTFELy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 07:54:28 -0400
Date: Thu, 5 Jun 2003 13:12:20 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Thomas Kaeding <kaeding@kaeding.homelinux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at page_alloc.c:102
Message-ID: <20030605121220.GA30411@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Thomas Kaeding <kaeding@kaeding.homelinux.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0306050752400.759-100000@kaeding.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306050752400.759-100000@kaeding.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 07:55:08AM -0400, Thomas Kaeding wrote:
 > Hi,
 > 
 > My linux box froze up today.  My kernel is 2.4.20 with Mandrake's
 > supermount patch.  Attached is a snippet from sys.log.  Please
 > email me to let me know if this is a known bug, where the fix is,
 > or if anyone is working on it.  Thanks!

You're using the binary only NVIDIA module.
Unless you can repeat the bug without it, it's uninteresting, and you
should go hassle NVIDIA about it. They have our code, we don't have theirs.

		Dave

