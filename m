Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318286AbSG3PhN>; Tue, 30 Jul 2002 11:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318298AbSG3PhN>; Tue, 30 Jul 2002 11:37:13 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:1779 "EHLO e1.ny.us.ibm.com.")
	by vger.kernel.org with ESMTP id <S318286AbSG3PhM>;
	Tue, 30 Jul 2002 11:37:12 -0400
Subject: Re: Testing of filesystems
From: Paul Larson <plars@austin.ibm.com>
To: Alexander.Riesen@synopsys.com
Cc: JFS-Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, axel@hh59.org
In-Reply-To: <20020730121539.GA20781@riesen-pc.gr05.synopsys.com>
References: <20020730094902.GA257@prester.freenet.de> 
	<20020730121539.GA20781@riesen-pc.gr05.synopsys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 Jul 2002 10:36:41 -0500
Message-Id: <1028043402.11135.239.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-30 at 07:15, Alex Riesen wrote:
> On Tue, Jul 30, 2002 at 11:49:02AM +0200, Axel Siebenwirth wrote:
> > Hi,
> > 
> > I wonder what a good way is to stress test my JFS filesystem. Is there a tool
> > that does something like that maybe? Dont't want performance testing, just
> > all kinds of stress testing to see how the filesystem "is" and to check
> > integrity and functionality.
> > What are you filesystem developers use to do something like that?
You may also want to take a look at the tests in the Linux Test
Project.  There are several tests there that target the filesystem.

Paul Larson
Linux Test Project
http://ltp.sourceforge.net

