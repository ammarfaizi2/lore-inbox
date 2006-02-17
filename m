Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161152AbWBQJT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161152AbWBQJT1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 04:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161167AbWBQJT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 04:19:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45998 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161152AbWBQJT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 04:19:26 -0500
Subject: Re: host_driver: Unknown symbol tcp_protocol
From: Arjan van de Ven <arjan@infradead.org>
To: George P Nychis <gnychis@cmu.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <56682.128.237.252.29.1140164271.squirrel@128.237.252.29>
References: <56682.128.237.252.29.1140164271.squirrel@128.237.252.29>
Content-Type: text/plain
Date: Fri, 17 Feb 2006 10:19:22 +0100
Message-Id: <1140167963.2980.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-17 at 03:17 -0500, George P Nychis wrote:
> Hi,
> 
> I am trying to compile a module that uses:
> extern struct net_protocol tcp_protocol;  /* The TCP protocol already defined */

which module is this??

