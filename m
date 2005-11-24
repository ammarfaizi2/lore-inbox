Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030558AbVKXHb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030558AbVKXHb1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 02:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030557AbVKXHb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 02:31:27 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:56488 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1030558AbVKXHb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 02:31:26 -0500
Date: Wed, 23 Nov 2005 23:30:16 -0800
From: Paul Jackson <pj@sgi.com>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: linux-os@analogic.com, francis_moreau2000@yahoo.fr,
       linux-kernel@vger.kernel.org
Subject: Re: Use enum to declare errno values
Message-Id: <20051123233016.4a6522cf.pj@sgi.com>
In-Reply-To: <200511240919.52650.vda@ilport.com.ua>
References: <20051123132443.32793.qmail@web25813.mail.ukl.yahoo.com>
	<200511231624.49208.vda@ilport.com.ua>
	<Pine.LNX.4.61.0511230958550.18085@chaos.analogic.com>
	<200511240919.52650.vda@ilport.com.ua>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If errno's were an enum type, what would be the type
of the return value of a variety of kernel routines
that now return an int, returning negative errno's on
error and zero or positive values on success?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
