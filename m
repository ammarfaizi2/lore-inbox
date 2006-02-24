Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWBXOdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWBXOdL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 09:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWBXOdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 09:33:11 -0500
Received: from cantor.suse.de ([195.135.220.2]:30670 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932183AbWBXOdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 09:33:10 -0500
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: Patch to make the head.S-must-be-first-in-vmlinux order explicit
Date: Fri, 24 Feb 2006 15:32:58 +0100
User-Agent: KMail/1.9.1
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
References: <1140700758.4672.51.camel@laptopd505.fenrus.org> <m11wxs50ki.fsf@ebiederm.dsl.xmission.com> <43FF0FE5.8040300@linux.intel.com>
In-Reply-To: <43FF0FE5.8040300@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602241532.59026.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 February 2006 14:53, Arjan van de Ven wrote:
 
> I've looked some yesterday at generating this at runtime, and haven't 
> found a clean enough solution yet (esp one that doesn't break kdump); 
> I'll keep poking at it for a bit more though....


Ok if it's too complicated we can force it first.

-Andi
