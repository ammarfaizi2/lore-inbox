Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbTIYINK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 04:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbTIYINK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 04:13:10 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:58895 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261771AbTIYINF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 04:13:05 -0400
Message-ID: <3F72A59D.4000407@aitel.hist.no>
Date: Thu, 25 Sep 2003 10:21:49 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: "Johnson, Richard" <rjohnson@analogic.com>
CC: linux-kernel@vger.kernel.org
Subject: [OT] Re: Horiffic SPAM
References: <Pine.LNX.4.53.0309231408260.28457@quark.analogic.com> <20030923183648.GE1269@velociraptor.random> <Pine.LNX.4.53.0309241006500.30216@quark.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Tue, 23 Sep 2003, Andrea Arcangeli wrote:
> 
> 
>>On Tue, Sep 23, 2003 at 02:11:59PM -0400, Richard B. Johnson wrote:
>>

> Well it seems that fire-walling the SPAM servers is *not* a good idea.
> They are persistant, gang up, and will not give up until they are
> able to deliver the mail! When I firewall them, my network traffic

According to standards they will give up after 5 days or so.

> ends up being continuous SYN floods as every spam-server in the
> country tries to connect. It doesn't do any good to set `ipchains` to
> REJECT instead of DENY. They just keep on banging on the door.
> 

Have you considered teergrubing them instead?  That ought to
fix the bandwith problem.  And it is not so fun for whoever has
the spam server either - either disrupting some spammers operation
or harassing some server admin into making his box un-abuseable.


Helge Hafting

