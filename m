Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbVCDJKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbVCDJKk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 04:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVCDJKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 04:10:39 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:37811 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262172AbVCDJIh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 04:08:37 -0500
Subject: Re: 2.6.11-rc5-mm1: reiser4 eating cpu time
From: Vladimir Saveliev <vs@namesys.com>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <200503040224.36516@zodiac.zodiac.dnsalias.org>
References: <200503040224.36516@zodiac.zodiac.dnsalias.org>
Content-Type: text/plain
Message-Id: <1109927249.11221.26.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 04 Mar 2005 12:07:30 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Fri, 2005-03-04 at 04:24, Alexander Gran wrote:
> Hi,
> 
> I have a reiser4 partition on a local IDE disk. I opened a 130MB textfile with 
> kwrite, 
..
>  Process was eating 100% CPU time for several (54) seconds.
> Is this a normal, expected behaviour?

no, thanks for report, I will investigate.



