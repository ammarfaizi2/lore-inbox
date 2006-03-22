Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWCVP3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWCVP3S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWCVP3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:29:18 -0500
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:32173 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751324AbWCVP3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:29:16 -0500
Date: Wed, 22 Mar 2006 10:29:14 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Chris Wright <chrisw@sous-sol.org>
cc: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
       virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC PATCH 34/35] Add the Xen virtual network device driver.
In-Reply-To: <20060322063808.464342000@sorel.sous-sol.org>
Message-ID: <Pine.LNX.4.64.0603221027180.16121@excalibur.intercode>
References: <20060322063040.960068000@sorel.sous-sol.org>
 <20060322063808.464342000@sorel.sous-sol.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2006, Chris Wright wrote:

> The network device frontend driver allows the kernel to access network
> devices exported exported by a virtual machine containing a physical
> network device driver.

I'd suggest cc'ing network related patches to netdev@vger.kernel.org.



- James
-- 
James Morris
<jmorris@namei.org>
