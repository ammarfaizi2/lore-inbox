Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751476AbWCXAjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbWCXAjH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 19:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWCXAjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 19:39:07 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:37018 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751476AbWCXAjG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 19:39:06 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-mm1
Date: Fri, 24 Mar 2006 01:38:11 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
References: <20060323014046.2ca1d9df.akpm@osdl.org> <200603232317.50245.Rafal.Wysocki@fuw.edu.pl> <20060323160426.153fbea9.akpm@osdl.org>
In-Reply-To: <20060323160426.153fbea9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603240138.12147.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 March 2006 01:04, Andrew Morton wrote:
> "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl> wrote:
> >
> > On Thursday 23 March 2006 10:40, Andrew Morton wrote:
> > > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm1/
> > 
> > On a uniprocessor AMD64 w/ CONFIG_SMP unset (2.6.16-rc6-mm2 works on this box
> > just fine, .config attached):
> 
> hm, uniproc x86_64 seems to cause problems sometimes.  I should test it more.

Well, I'll be doing this anyway. ;-)
