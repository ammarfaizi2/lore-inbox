Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751873AbWFUAWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbWFUAWs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 20:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbWFUAWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 20:22:48 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:58498 "EHLO
	sequoia.sous-sol.org") by vger.kernel.org with ESMTP
	id S1751873AbWFUAWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 20:22:47 -0400
Date: Tue, 20 Jun 2006 17:22:07 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       jeremy@xensource.com
Subject: Re: [PATCH 2.6.17] Clean up and refactor i386 sub-architecture setup
Message-ID: <20060621002207.GM22737@sequoia.sous-sol.org>
References: <44988803.5090305@goop.org> <44988E08.9070000@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44988E08.9070000@vmware.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> This looks awesome.   Are there any plans to get these sub-architectures 
> to work with the generic subarch?  Seems the next logical step would be 
> putting each mach-*/*.o into separated namespaces.

Well, to be honest, I had considered it in the 'would be nice someday'
category, so I have not looked too deeply into how to get there from here.
I think a distro kernel would ultimately like that though.

thanks,
-chris
