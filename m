Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbUKCM52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbUKCM52 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 07:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbUKCM42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 07:56:28 -0500
Received: from cantor.suse.de ([195.135.220.2]:49835 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261583AbUKCM4O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 07:56:14 -0500
Date: Wed, 3 Nov 2004 13:46:42 +0100
From: Andi Kleen <ak@suse.de>
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: dmi_scan on x86_64
Message-ID: <20041103124642.GD18867@wotan.suse.de>
References: <b4V55sKZ.1099483813.4024460.khali@gcu.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4V55sKZ.1099483813.4024460.khali@gcu.info>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 01:10:14PM +0100, Jean Delvare wrote:
> 
> Hi there,
> 
> Any reason why dmi_scan is availble on the i386 arch and not on the
> x86_64 arch? I would have a need for the latter (for run-time
> identification purposes, not boot-time blacklisting).

So far nothing needed it, so I didn't add it.  For what do you need it? 

-Andi
