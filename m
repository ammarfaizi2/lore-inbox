Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVADCMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVADCMd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 21:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVADCMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 21:12:33 -0500
Received: from holomorphy.com ([207.189.100.168]:34945 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261960AbVADCMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 21:12:24 -0500
Date: Mon, 3 Jan 2005 18:12:16 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Colin Coe <colin@coesta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Max CPUs on x86_64 under 2.6.x
Message-ID: <20050104021216.GA2708@holomorphy.com>
References: <44438.202.154.120.74.1104760841.squirrel@www.coesta.com> <20050103221516.GV29332@holomorphy.com> <45567.202.154.120.74.1104797829.squirrel@www.coesta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45567.202.154.120.74.1104797829.squirrel@www.coesta.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 08:17:09AM +0800, Colin Coe wrote:
> Just one more question, what is the '64 cpus' that you are referring to? 
> The ./arch/x86_64/Kconfig file states:

The "64 cpus" referred to a comparison between i386 and x86-64. i386
SMP machines having 64 cpus were the largest ever constructed with
those particular cpus. No assertion regarding x86-64 systems was
intended to be made by that particular statement.


-- wli
