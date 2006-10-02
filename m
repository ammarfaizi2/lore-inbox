Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965261AbWJBS3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965261AbWJBS3s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 14:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965234AbWJBS3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 14:29:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31723 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965261AbWJBS3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 14:29:46 -0400
Date: Mon, 2 Oct 2006 11:29:39 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Valdis.Kletnieks@vt.edu
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Spam, bogofilter, etc
In-Reply-To: <200610021822.k92IMo44008167@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.64.0610021129150.3952@g5.osdl.org>
References: <1159539793.7086.91.camel@mindpipe> <20061002100302.GS16047@mea-ext.zmailer.org>
 <1159802486.4067.140.camel@mindpipe> <45212F39.5000307@mbligh.org>
 <Pine.LNX.4.64.0610020933020.3952@g5.osdl.org> <1159811392.8907.36.camel@localhost.localdomain>
            <Pine.LNX.4.64.0610021050350.3952@g5.osdl.org>
 <200610021822.k92IMo44008167@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 Oct 2006, Valdis.Kletnieks@vt.edu wrote:
> 
> How did OSDL's MX checking deal with split in/out configurations like ours,
> where our MX points at a load-balanced farm of Mirapoint front end appliances
> with 1 IP address, but our main off-campus *outbound* comes from a different
> address?

Hey, if I knew what I was doing, I'd be in MIS. 

As it is, I just criticise other peoples patches.

		Linus
