Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWFMWNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWFMWNl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 18:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWFMWNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 18:13:41 -0400
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:59820 "EHLO
	mail8.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932286AbWFMWNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 18:13:40 -0400
Date: Tue, 13 Jun 2006 18:13:38 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Sridhar Samudrala <sri@us.ibm.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 2/2] update sunrpc to use in-kernel sockets API
In-Reply-To: <1150215626.31720.9.camel@w-sridhar2.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.64.0606131812070.6488@d.namei>
References: <1150156564.19929.33.camel@w-sridhar2.beaverton.ibm.com> 
 <Pine.LNX.4.64.0606122320010.31627@d.namei> <448E42AE.1010901@us.ibm.com> 
 <Pine.LNX.4.64.0606131006250.3553@d.namei> <1150215626.31720.9.camel@w-sridhar2.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2006, Sridhar Samudrala wrote:

> My patch doesn't touch this section of the code and this is called 
> after the assignment we are talking about. So we should be using the
> right sendpage in the actual call.

Ok.

Acked-by: James Morris <jmorris@namei.org>

(for both patches).

-- 
James Morris
<jmorris@namei.org>
