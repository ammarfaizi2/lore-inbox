Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWAaQja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWAaQja (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 11:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWAaQja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 11:39:30 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:18082 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751188AbWAaQj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 11:39:29 -0500
Date: Tue, 31 Jan 2006 11:39:28 -0500
To: Sander <sander@humilis.net>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [OT] 8-port AHCI SATA Controller?
Message-ID: <20060131163928.GE18972@csclub.uwaterloo.ca>
References: <20060131115343.GA2580@favonius>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060131115343.GA2580@favonius>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 12:53:43PM +0100, Sander wrote:
> I'm looking for an 8-port SATA controller based on the AHCI chipset, as
> according to http://linux.yyz.us/sata/sata-status.html#vendor_support
> this chipset is completely open.

Hmm, I am not sure what the specs of AHCI are.  Not sure if it supports
2 or 4 or more ports.  The only controllers I have seen that run more
than 4 ports, are some raid cards, such as 3ware and areca.  3ware has
had linux support for years, and areca is getting there.  Both of those
make 12+ port cards, which can run in JBOD mode.

Len Sorensen
