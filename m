Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264470AbTLCDKO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 22:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264472AbTLCDKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 22:10:14 -0500
Received: from bay7-f83.bay7.hotmail.com ([64.4.11.83]:6407 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S264470AbTLCDKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 22:10:12 -0500
X-Originating-IP: [209.98.246.157]
X-Originating-Email: [joeblow341@hotmail.com]
From: "Joe Blow" <joeblow341@hotmail.com>
To: andersen@codepoet.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Promise 20378 + 2.6.0-test10 + libata patch 1
Date: Wed, 03 Dec 2003 03:10:10 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY7-F83MLR6utNNYUR00004e92@hotmail.com>
X-OriginalArrivalTime: 03 Dec 2003 03:10:11.0081 (UTC) FILETIME=[F6800790:01C3B94A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Erik Andersen <andersen@codepoet.org>
>What exactly is needed to get got SATA and PATA support
>comparable to the driver provided by promise?  Would it be
>possible to adapt the existing promise PATA IDE driver to drive
>the PATA port, while the libata Promise driver handles the SATA
>ports.  Or would a new driver be needed?

Is there actually a Promise supplied driver that might work with the 20378 
and PATA drives?  Someone sent me a .zip file with an open source driver 
from Promise dated 02/20/03 but it's for 2.4.x.  I emailed Promise asking if 
there was an update, and they denied it even existed.

_________________________________________________________________
Wonder if the latest virus has gotten to your computer? Find out.  Run the 
FREE McAfee online  computer scan on your PC now! 
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963

