Return-Path: <linux-kernel-owner+w=401wt.eu-S1751441AbXAPCnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbXAPCnz (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 21:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbXAPCnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 21:43:55 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:37849 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751441AbXAPCny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 21:43:54 -0500
Date: Mon, 15 Jan 2007 18:43:13 -0800
From: Paul Jackson <pj@sgi.com>
To: "Bob Picco" <bob.picco@hp.com>
Cc: akpm@osdl.org, bob.picco@hp.com, linux-kernel@vger.kernel.org,
       clameter@sgi.com
Subject: Re: [PATCH] CPUSET related breakage of sys_mbind
Message-Id: <20070115184313.70ba25df.pj@sgi.com>
In-Reply-To: <20070115231050.GA32220@localhost>
References: <20070115231050.GA32220@localhost>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You're right about this problemI think that Christoph Lameter
(added to cc list) is working on a fix for this.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
