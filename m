Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWFUBcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWFUBcp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 21:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbWFUBcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 21:32:45 -0400
Received: from gw.goop.org ([64.81.55.164]:47836 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750820AbWFUBcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 21:32:45 -0400
Message-ID: <4498A1C0.1040603@goop.org>
Date: Tue, 20 Jun 2006 18:32:48 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       jeremy@xensource.com
Subject: Re: [PATCH 2.6.17] Clean up and refactor i386 sub-architecture setup
References: <44988803.5090305@goop.org> <44988E08.9070000@vmware.com> <449891B9.3060409@goop.org> <4498958B.504@vmware.com> <44989E25.3090402@goop.org> <44989FD3.1040805@vmware.com>
In-Reply-To: <44989FD3.1040805@vmware.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden wrote:
> I was thinking more of having mach-xen/built-in.o, 
> mach-default/built-in.o, mach-es7000/built-in.o, 
> mach-voyager/built-in.o all be linked specially so they can be 
> compiled into the same kernel either as one giant batch
Yeah, that would be nice.

    J
