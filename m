Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751579AbWDAWdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbWDAWdA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 17:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751622AbWDAWdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 17:33:00 -0500
Received: from gate.ebshome.net ([64.81.67.12]:21424 "EHLO gate.ebshome.net")
	by vger.kernel.org with ESMTP id S1751579AbWDAWdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 17:33:00 -0500
Date: Sat, 1 Apr 2006 14:32:59 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jbeulich@novell.com, linuxppc-dev@ozlabs.org
Subject: Re: "tvec_bases too large for per-cpu data" commit broke early_serial_setup()
Message-ID: <20060401223259.GB5748@gate.ebshome.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, jbeulich@novell.com,
	linuxppc-dev@ozlabs.org
References: <20060401205336.GA5748@gate.ebshome.net> <20060401140610.2ec67738.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060401140610.2ec67738.akpm@osdl.org>
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
X-PGP-Key: http://www.ebshome.net/pubkey.asc
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2006 at 02:06:10PM -0800, Andrew Morton wrote:

[snip]

> Early boot is ugly.
> 
> Does this fix it?

Yep, it works now.

Thanks, Andrew.

-- 
Eugene
