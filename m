Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268536AbUILTxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268536AbUILTxp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 15:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268565AbUILTxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 15:53:44 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:30988 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S268536AbUILTxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 15:53:42 -0400
Date: Sun, 12 Sep 2004 21:53:31 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Wolfpaw - Dale Corse <admin@wolfpaw.net>
Cc: toon@hout.vanvergehaald.nl, kaukasoi@elektroni.ee.tut.fi,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified) Denial of Service Attack
Message-ID: <20040912195331.GC2780@alpha.home.local>
References: <02bf01c498ff$b6512470$0300a8c0@s> <002c01c49900$a20df550$0200a8c0@wolf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002c01c49900$a20df550$0200a8c0@wolf>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 01:42:26PM -0600, Wolfpaw - Dale Corse wrote:
 
> MD5 encryption was added to the sessions between
> routers to make hijacking the stream more difficult
> (if not next to impossible)

Correction : MD5 *signature* was added from the beginning since the problem
was identified from start, but seeing that certain people did not implement
it, others found interesting to turn this into a "generic TCP vulnerability"
to get some credits, or perhaps to make them react positively.

Regards,
Willy

