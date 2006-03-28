Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWC1EMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWC1EMV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 23:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWC1EMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 23:12:21 -0500
Received: from rwcrmhc14.comcast.net ([204.127.192.84]:30853 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1750972AbWC1EMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 23:12:20 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: OOM kills if swappiness set to 0, swap storms otherwise
Date: Mon, 27 Mar 2006 23:12:17 -0500
User-Agent: KMail/1.9.1
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
References: <1143510828.1792.353.camel@mindpipe> <20060327195905.7f666cb5.akpm@osdl.org>
In-Reply-To: <20060327195905.7f666cb5.akpm@osdl.org>
X-Face: M;&!dfz|m-o'K\Cz\J=6-U&/;8+edm=snaTAX=*NtQpWX@=?utf-8?q?156L1=25mHDt3XI=25X!5Hw3U+pe=0A=09nazcjJnz?=>75*V8\Sz\]3brW#a+Oa,8P7p6L+sVZkP;ZwyeKR0o`*#k2zD&!2Mn,0d3<=?utf-8?q?7qa=0A=096=25?=>g:?bp|XU>`.|?x2l;ounL%k85<JW7G=Df&(@a?]WbFJ{3aEyx4\`#@=?utf-8?q?JXn=7C4Le8c=3BbgI=0A=09JIayR9DG=24hLN8!=5B=5B*=60T=5FY=7Bx?=(y>T/KB"2a|vqpcO*?ngOt-V0Lo5nTA{)=?utf-8?q?k+Pm=7CokhK=60=5BikO=0A=09=3BlvKCYCBdfs=7EQ?=
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603272312.18252.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 March 2006 22:59, Andrew Morton wrote:
> I'd tentatively say that your options are to put up
> with the swapping or find a new mail client.

I tried mem=512m , swapoff -a and swappiness=0 and all works fine for me on 
x86. I use Evolution and Firefox's KDE counterparts - in addition to that 
Amarok, Kopete and Akregator fit in too.

Lee - Perhaps you are running fat 64 bit code?

Parag
