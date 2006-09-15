Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWIOQq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWIOQq2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 12:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWIOQq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 12:46:28 -0400
Received: from smtp-out.google.com ([216.239.45.12]:36954 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750762AbWIOQq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 12:46:27 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=VV3Ln42FMv3yxzfuvxxiARDZq0IkBOZn4ByfwHf+FruNRHrAA1fplCiJuFU0rf2e2
	z4jPjWaUU5IWxjlwWb+ew==
Subject: Re: [Devel] Re: [Patch 01/05]- Containers: Documentation on using
	containers
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Kir Kolyshkin <kir@openvz.org>
Cc: devel@openvz.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
In-Reply-To: <450A7C98.3060106@openvz.org>
References: <1158284314.5408.146.camel@galaxy.corp.google.com>
	 <200609150815.19917.eike-kernel@sf-tec.de>  <450A7C98.3060106@openvz.org>
Content-Type: text/plain
Organization: Google Inc
Date: Fri, 15 Sep 2006 09:46:07 -0700
Message-Id: <1158338767.12311.27.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-15 at 14:12 +0400, Kir Kolyshkin wrote:
> Rolf Eike Beer wrote:
> > Please also give a short description what containers are for. From 
> > what I read
> > here I can only guess it's about gettings some statistics about a group of 
> > tasks.
> >   
> Container is like FreeBSD Jail on steroids (and Jail is chroot() on 
> steroids).


Nice choice of words!

-rohit

