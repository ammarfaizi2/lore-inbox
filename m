Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264147AbUFKRT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUFKRT1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 13:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264226AbUFKRT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 13:19:27 -0400
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:38151 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S264147AbUFKRT0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 13:19:26 -0400
Date: Fri, 11 Jun 2004 19:21:16 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, sensors@Stimpy.netroedge.com,
       rtjohnso@eecs.berkeley.edu, linux-kernel@vger.kernel.org
Subject: Re: Finding user/kernel pointer bugs [no html]
Message-Id: <20040611192116.1bb87553.khali@linux-fr.org>
In-Reply-To: <20040610191004.GA1661@kroah.com>
References: <1086838266.32059.320.camel@dooby.cs.berkeley.edu>
	<20040610044903.GE12308@parcelfarce.linux.theplanet.co.uk>
	<20040610165821.GB32577@kroah.com>
	<20040610191004.GA1661@kroah.com>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And to be complete, here's a patch to clean up the warnings in the
> drivers/i2c tree.  I've also applied it to my trees.
> (...)
> # I2C: sparse cleanups for drivers/i2c/*

Should any of these be backported to i2c in 2.4?

-- 
Jean Delvare
http://khali.linux-fr.org/
