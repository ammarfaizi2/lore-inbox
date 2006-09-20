Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751885AbWITQqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbWITQqS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 12:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbWITQqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 12:46:18 -0400
Received: from smtp-out.google.com ([216.239.45.12]:7081 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751885AbWITQqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 12:46:17 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=Ghtir1pl5kC1EkYVl7utyddBsZYiy0O92EEa82MWxQmwWWg7ISS30UpztFlGHJZ+w
	1hiQUMY+wUjWxUaFZnGUg==
Subject: Re: [Devel] [patch00/05]: Containers(V2)- Introduction
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: devel@openvz.org, linux-kernel <linux-kernel@vger.kernel.org>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
In-Reply-To: <45113CF3.8010308@fr.ibm.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <45113CF3.8010308@fr.ibm.com>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 20 Sep 2006 09:45:43 -0700
Message-Id: <1158770743.8574.28.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 15:06 +0200, Cedric Le Goater wrote:
> Rohit Seth wrote:
> > 
> > This is based on lot of discussions over last month or so.  I hope this
> > patch set is something that we can agree and more support can be added
> > on top of this.  Please provide feedback and add other extensions that
> > are useful in the TODO list.
> 
> thanks rohit for this patchset. 
> 
> I applied it on rc7-mm1, compiles smoothly and boots. Here's a edge 
> issue, I got this oops while rmdir a container with running tasks. 
> 

Thanks for pointing this out. I will look into this and send the update.

-rohit


