Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752200AbWJ0Oo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200AbWJ0Oo2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 10:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752201AbWJ0Oo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 10:44:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43990 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751011AbWJ0Oo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 10:44:27 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1161884706.16681.270.camel@moss-spartans.epoch.ncsc.mil> 
References: <1161884706.16681.270.camel@moss-spartans.epoch.ncsc.mil>  <1161880487.16681.232.camel@moss-spartans.epoch.ncsc.mil> <1161867101.16681.115.camel@moss-spartans.epoch.ncsc.mil> <1161810725.16681.45.camel@moss-spartans.epoch.ncsc.mil> <16969.1161771256@redhat.com> <8567.1161859255@redhat.com> <22702.1161878644@redhat.com> <24017.1161882574@redhat.com> 
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: David Howells <dhowells@redhat.com>, aviro@redhat.com,
       linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
       chrisw@sous-sol.org, jmorris@namei.org
Subject: Re: Security issues with local filesystem caching 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 27 Oct 2006 15:41:50 +0100
Message-ID: <27450.1161960110@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> When the daemon writes the context value (a string) to the cachefiles
> module interface for a given cache, the cachefiles module would do
> something like the following:

What would such a context value look like?  I don't really know much about
configuring SELinux.  Would it just be the name of a security label?

David
