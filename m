Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263949AbTDNVqD (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263961AbTDNVpj (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:45:39 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:35014 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263949AbTDNVof (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 17:44:35 -0400
Date: Mon, 14 Apr 2003 22:55:55 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: BUGed to death
Message-ID: <20030414215550.GB24096@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@digeo.com>, mbligh@aracnet.com,
	linux-kernel@vger.kernel.org
References: <80690000.1050351598@flay> <20030414210006.GA7831@suse.de> <92940000.1050353740@flay> <20030414210856.GA10688@suse.de> <20030414145028.2b37e226.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030414145028.2b37e226.akpm@digeo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 02:50:28PM -0700, Andrew Morton wrote:

 > 	if (foo == NULL)
 > 		BUG();
 > 	*foo = bar;
 > 
 > The BUG is a waste of space.

Agreed. That is somewhat silly.

		Dave

