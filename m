Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270792AbUJUPpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270792AbUJUPpe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 11:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270723AbUJUPpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 11:45:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51366 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S270774AbUJUPaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 11:30:39 -0400
Date: Thu, 21 Oct 2004 11:29:30 -0400
From: Dave Jones <davej@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.6.9-ac1: invalid SUBLEVEL
Message-ID: <20041021152930.GH26170@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Adrian Bunk <bunk@stusta.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1098356892.17052.18.camel@localhost.localdomain> <20041021124945.GD10801@stusta.de> <1098365506.17096.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098365506.17096.23.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 02:31:47PM +0100, Alan Cox wrote:
 > On Iau, 2004-10-21 at 13:49, Adrian Bunk wrote:
 > >  VERSION = 2
 > >  PATCHLEVEL = 6
 > > -SUBLEVEL = 9-ac1
 > > -EXTRAVERSION =
 > > +SUBLEVEL = 9
 > > +EXTRAVERSION = -ac1
 > >  NAME=AC 1
 > 
 > Doh I'm -amazed- that worked for me. Fixed in my tree, I'll go and hide
 > in a corner for a bit.
 
I think we can forgive you Alan, clearly you're out of practise 8-)

		Dave

