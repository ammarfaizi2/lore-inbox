Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbUDSWQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUDSWQA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 18:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbUDSWQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 18:16:00 -0400
Received: from 213-0-215-223.dialup.nuria.telefonica-data.net ([213.0.215.223]:20619
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S261931AbUDSWP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 18:15:59 -0400
Date: Tue, 20 Apr 2004 00:16:13 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: John Pesce <pescej@sprl.db.erau.edu>
Cc: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>,
       linux-kernel@vger.kernel.org
Subject: Re: How to make Linux route multicast traffic bi-directionly between multible subnets
Message-ID: <20040419221613.GA22634@localhost>
Mail-Followup-To: John Pesce <pescej@sprl.db.erau.edu>,
	"Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
	Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>,
	linux-kernel@vger.kernel.org
References: <1082389059.1982.15.camel@inferno> <20040419200739.GA3020@localhost> <40843363.4070903@backtobasicsmgmt.com> <1082410441.1971.27.camel@inferno>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082410441.1971.27.camel@inferno>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 19 April 2004, at 17:34:01 -0400,
John Pesce wrote:

> Can you point me to a specific location for "the" mrouted demon you are
> referring to ;)
> 
Maybe is not the same as I used, but Debian's SID "mrouted" package
work by default, at least it runs ok and boots, and learns some routes.
Take into account that my setup consisted of a real ethernet interface
(eth0) and a couple of dummy interfaces (dummy0, dummy1). No real-world
configuration, but the daemon seems to work fine, and comes already
compiled and runs with no changes over 2.6.x kernels.

Greetings.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.5)
