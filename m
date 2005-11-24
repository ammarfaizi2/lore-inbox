Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932522AbVKXHiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbVKXHiu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 02:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbVKXHiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 02:38:50 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:45019 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932522AbVKXHiu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 02:38:50 -0500
Date: Wed, 23 Nov 2005 23:37:50 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: vda@ilport.com.ua, linux-os@analogic.com, francis_moreau2000@yahoo.fr,
       linux-kernel@vger.kernel.org
Subject: Re: Use enum to declare errno values
Message-Id: <20051123233750.3a2f525a.pj@sgi.com>
In-Reply-To: <20051123233016.4a6522cf.pj@sgi.com>
References: <20051123132443.32793.qmail@web25813.mail.ukl.yahoo.com>
	<200511231624.49208.vda@ilport.com.ua>
	<Pine.LNX.4.61.0511230958550.18085@chaos.analogic.com>
	<200511240919.52650.vda@ilport.com.ua>
	<20051123233016.4a6522cf.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nevermind my question- Looks like moreau francis already noted:

> I guess we won't use enumeration because it needs to many changes...Each
> function that returns a errno value should have their prototype changed 

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
