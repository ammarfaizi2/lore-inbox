Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVAMRed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVAMRed (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVAMR1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:27:49 -0500
Received: from picard.ine.co.th ([203.152.41.3]:60859 "EHLO picard.ine.co.th")
	by vger.kernel.org with ESMTP id S261295AbVAMR0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:26:30 -0500
Subject: Re: kernel (64bit) 4GB memory support
From: Rudolf Usselmann <rudi@asics.ws>
Reply-To: rudi@asics.ws
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: "Frank Denis (Jedi/Sector One)" <j@pureftpd.org>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <Pine.LNX.4.61.0412210930280.28648@montezuma.fsmlabs.com>
References: <41BAC68D.6050303@pobox.com> <1102760002.10824.170.camel@cpu0>
	 <41BB32A4.2090301@pobox.com> <1102824735.17081.187.camel@cpu0>
	 <Pine.LNX.4.61.0412112141180.7847@montezuma.fsmlabs.com>
	 <1102828235.17081.189.camel@cpu0>
	 <Pine.LNX.4.61.0412120131570.7847@montezuma.fsmlabs.com>
	 <1102842902.10322.200.camel@cpu0>
	 <Pine.LNX.4.61.0412120934160.14734@montezuma.fsmlabs.com>
	 <1103027130.3650.73.camel@cpu0>  <20041216074905.GA2417@c9x.org>
	 <1103213359.31392.71.camel@cpu0>
	 <Pine.LNX.4.61.0412201246180.12334@montezuma.fsmlabs.com>
	 <1103646195.3652.196.camel@cpu0>
	 <Pine.LNX.4.61.0412210930280.28648@montezuma.fsmlabs.com>
Content-Type: text/plain
Organization: ASICS.ws - Solutions for your ASICS & FPGA needs -
Date: Fri, 14 Jan 2005 00:26:18 +0700
Message-Id: <1105637178.5491.167.camel@cpu10>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-21 at 09:33 -0700, Zwane Mwaikambo wrote:
> On Tue, 21 Dec 2004, Rudolf Usselmann wrote:
> 
> > I mean you guys must have a pretty good idea what is going wrong.
> > Is it possible to add some debugging information ? The latest
> > mm4-jeda kernel seems to be able to "recover" from panics/crashes.
> > It doesn't "die" it just kills the offending app (at least thats
> > my limited understanding).
> 
> Ok don't worry about trying to isolate it, there should be a fix for it by 
> 2.6.10.
> 
> Thanks,
> 	Zwane

Hi Zwane !

just wondering if there where any fixes submitted with 2.6.10
final release for the memory problem. I did not see anything
from bugzilla ....

Kind Regards,
rudi

