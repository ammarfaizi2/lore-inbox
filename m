Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWIJPuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWIJPuA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 11:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWIJPuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 11:50:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35007 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932261AbWIJPt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 11:49:59 -0400
Date: Sun, 10 Sep 2006 11:57:05 -0400
From: Dave Jones <davej@redhat.com>
To: mwitosz-linux <mwitosz-linux@o2.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem with OWN bit when writting driver for rtl8139?
Message-ID: <20060910155705.GB4743@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	mwitosz-linux <mwitosz-linux@o2.pl>, linux-kernel@vger.kernel.org
References: <231c973f.7ffabfd8.450421ed.620bc@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <231c973f.7ffabfd8.450421ed.620bc@o2.pl>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2006 at 04:32:13PM +0200, mwitosz-linux wrote:
 > hi, everybody
 > my name is Mariusz, I am newbie to linux kernel, 
 > For several weeks I have been writing kernel driver for network card based on 
 > rtl8139c chip. 

You do realise that 8139too already supports 8139C ?

	Dave
