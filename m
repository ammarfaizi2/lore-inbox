Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbUKXJw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbUKXJw7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 04:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbUKXJw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 04:52:58 -0500
Received: from linux2.isphuset.no ([213.236.237.186]:16336 "EHLO
	gtw.mailserveren.com") by vger.kernel.org with ESMTP
	id S262585AbUKXJwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 04:52:54 -0500
Subject: Re: Network slowdown from 2.6.7 to 2.6.9
From: Hans Kristian Rosbach <hk@isphuset.no>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Stephen Hemminger <shemminger@osdl.org>
In-Reply-To: <20041123100450.3cbb82e6@zqx3.pdx.osdl.net>
References: <419A9151.2000508@atmos.washington.edu>
	 <20041116163257.0e63031d@zqx3.pdx.osdl.net>
	 <cone.1100651833.776334.15267.502@pc.kolivas.org>
	 <419BA5C4.4020503@atmos.washington.edu>
	 <1100722571.20185.9.camel@tux.rsn.bth.se>
	 <419BBF57.3040808@atmos.washington.edu>
Content-Type: text/plain
Organization: ISPHuset Nordic AS
Message-Id: <1101289960.2337.8.camel@linux.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 24 Nov 2004 10:52:41 +0100
Content-Transfer-Encoding: 7bit
X-Declude-Sender: hk@isphuset.no [195.159.151.115]
X-Note: This E-mail was scanned by Declude JunkMail (www.declude.com) for spam.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-23 at 19:04, Stephen Hemminger wrote:
> Also, 2.6.9 has TCP bugs with TSO that can cause panic's.
> These have been fixed in 2.6.10-rc2.

Shouldn't this patch be backported and make 2.6.9.1 ?

-=Dead2=-

