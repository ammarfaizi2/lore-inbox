Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264506AbTL3E7l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 23:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264485AbTL3E7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 23:59:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26000 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264477AbTL3E7k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 23:59:40 -0500
Message-ID: <3FF10629.8080301@pobox.com>
Date: Mon, 29 Dec 2003 23:59:21 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Feldman, Scott" <scott.feldman@intel.com>
CC: Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org
Subject: Re: [OOPS][2.6.0][e100 new driver] mii-diag oops with -F option
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102229BE5@orsmsx402.jf.intel.com>
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E0102229BE5@orsmsx402.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Feldman, Scott wrote:
> So e100-3.0.x is pending in -exp queue for 2.6.1; do we fix 2.6.0?


I'll go ahead and expedite the __devinit removal to Linus for now

	Jeff



