Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268191AbTB1WAm>; Fri, 28 Feb 2003 17:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268209AbTB1WAm>; Fri, 28 Feb 2003 17:00:42 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37391 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268191AbTB1WAm>; Fri, 28 Feb 2003 17:00:42 -0500
Date: Fri, 28 Feb 2003 22:11:01 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: dsaxena@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: Proposal: Eliminate GFP_DMA
Message-ID: <20030228221101.B18571@flint.arm.linux.org.uk>
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>, dsaxena@mvista.com,
	linux-kernel@vger.kernel.org
References: <1046445897.16599.60.camel@irongate.swansea.linux.org.uk> <Pine.SGI.4.10.10302282138180.244855-100000@Sky.inp.nsk.su> <20030228155841.GA4678@gtf.org> <mailman.1046456425.7772.linux-kernel2news@redhat.com> <200302282051.h1SKpNm32220@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200302282051.h1SKpNm32220@devserv.devel.redhat.com>; from zaitcev@redhat.com on Fri, Feb 28, 2003 at 03:51:23PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 03:51:23PM -0500, Pete Zaitcev wrote:
> Pay it no mind and
> implement it properly, that means copy it from sparc64.

and fix the documentation so the next unsuspecting individual doesn't
fall into the same trap and ask the same question on the same mailing
list. 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

