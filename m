Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262455AbVA0AZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbVA0AZw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVA0AYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:24:50 -0500
Received: from www.missl.cs.umd.edu ([128.8.126.38]:14099 "EHLO
	www.missl.cs.umd.edu") by vger.kernel.org with ESMTP
	id S262455AbVAZX6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 18:58:43 -0500
Date: Wed, 26 Jan 2005 19:28:41 -0500 (EST)
From: Adam Sulmicki <adam@cfar.umd.edu>
X-X-Sender: adam@www.missl.cs.umd.edu
To: "Robert W. Fuller" <orangemagicbus@sbcglobal.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: porting Linux to a virtual machine
In-Reply-To: <41F7377E.8050106@sbcglobal.net>
Message-ID: <Pine.BSF.4.62.0501261927590.497@www.missl.cs.umd.edu>
References: <41F7377E.8050106@sbcglobal.net>
X-WEB: http://www.eax.com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2005, Robert W. Fuller wrote:

> Has anybody ported Linux to a virtual machine?  Does anybody have any 
> pointers aside from the lkml's abbreviated FAQ entry concering porting 
> to a new processor?  What would be the best way of going about this? 
> Is there a supported architecture that is simpler than the others and/or 
> better to use as a model?  What about the UML (User Mode Linux) 
> architecture?  Are there doc's, FAQ's, etc. concerning this?  Should I 
> just read the mailing list and harvest the source code?  Thank you for 
> any (positive) input.

One word : xen

