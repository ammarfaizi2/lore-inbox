Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUEJSHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUEJSHY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 14:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbUEJSHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 14:07:24 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:31433 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261184AbUEJSHV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 14:07:21 -0400
Subject: Re: [PATCH] hci-usb bugfix
From: Marcel Holtmann <marcel@holtmann.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Sebastian Schmidt <yath@yath.eu.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0405101348080.669-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0405101348080.669-100000@ida.rowland.org>
Content-Type: text/plain
Message-Id: <1084212423.9639.47.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 10 May 2004 20:07:03 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

> > actually I don't see a reason for using both patches, because I can't
> > follow the point from Oliver that I've assumed a certain order of
> > disconnect.
> 
> I can't follow his point either.  Maybe he forgot that when the main 
> interface is disconnected the driver will release the SCO interface as 
> well.

I am going to submit my patch along with your altsettings patch for
inclusion now. So Greg don't have to worry about it.

Regards

Marcel


