Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965332AbWI0HNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965332AbWI0HNV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 03:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWI0HNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 03:13:21 -0400
Received: from ns2.suse.de ([195.135.220.15]:34986 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932455AbWI0HNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 03:13:21 -0400
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: 2.6.18-mm1
Date: Wed, 27 Sep 2006 09:13:15 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       adurbin@google.com
References: <20060924040215.8e6e7f1a.akpm@osdl.org> <m1mz8mqd4a.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1mz8mqd4a.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609270913.15688.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 September 2006 04:04, Eric W. Biederman wrote:
> 
> When I apply:
> x86_64-mm-insert-ioapics-and-local-apic-into-resource-map
> 
> My e1000 fails to initializes and complains about a bad eeprom checksum.
> I haven't tracked this down to root cause yet and I am in the process of building
> 2.6.18-mm1 with just that patch reverted to confirm that is the only cause.

Is this with Linux BIOS?

-Andi
