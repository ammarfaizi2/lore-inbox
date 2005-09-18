Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbVIRKlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbVIRKlE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 06:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbVIRKlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 06:41:04 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:59342 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1751074AbVIRKlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 06:41:03 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: Eradic disk access during reads
Date: Sun, 18 Sep 2005 13:40:28 +0300
User-Agent: KMail/1.8.2
Cc: Al Boldi <a1426z@gawab.com>, linux-kernel@vger.kernel.org
References: <200509170717.03439.a1426z@gawab.com> <200509171323.53054.a1426z@gawab.com> <20050917184643.GA1313@alpha.home.local>
In-Reply-To: <20050917184643.GA1313@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509181340.28683.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > You can do " readspeed </dev/hda | tr '\r' '\n' > log " with the readspeed
> > > tool from there :
> > >    http://w.ods.org/tools/readspeed
> > 
> > Does it have msec resolution?
> 
> no, it does not. It will only show you the average transfer rate during
> the past second each second. It often helps me tune network, nfs, raid, ...
> 
> Denis' tool seems clearly more suited to analyse your problem.

Denis' tool just got a homepage :)

http://195.66.192.167/linux/vdautil-0.5/src/
--
vda
