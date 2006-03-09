Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751928AbWCIPfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbWCIPfL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 10:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752002AbWCIPfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 10:35:10 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:8153 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751928AbWCIPfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 10:35:09 -0500
Subject: Re: 2.6.16-rc5 huge memory detection regression
From: Dave Hansen <haveblue@us.ibm.com>
To: Martin =?iso-8859-2?Q?MOKREJ=A9?= 
	<mmokrejs@ribosome.natur.cuni.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <44100AB3.5060004@ribosome.natur.cuni.cz>
References: <440D6581.9080000@ribosome.natur.cuni.cz>
	 <20060307041532.3ef45392.akpm@osdl.org>
	 <440D7BB8.40106@ribosome.natur.cuni.cz>
	 <20060307113631.36ac029d.akpm@osdl.org>
	 <1141765722.9274.105.camel@localhost.localdomain>
	 <440E172D.7000406@ribosome.natur.cuni.cz>
	 <1141774459.9274.142.camel@localhost.localdomain>
	 <44100AB3.5060004@ribosome.natur.cuni.cz>
Content-Type: text/plain; charset=iso-8859-2
Date: Thu, 09 Mar 2006 07:34:41 -0800
Message-Id: <1141918481.8599.125.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 12:00 +0100, Martin MOKREJ© wrote:
> So, what would you recommend now. To flash from BIOS 1.20 to 1.50 
> and pray? ;-) 

If it were hardware from a large vendor, I'd probably call support and
get them to ship me new parts. :)

Other than the BIOS update, there's not a whole lot you can do other
than move the DIMMS around and hope they prefer certain slots to others.

-- Dave

