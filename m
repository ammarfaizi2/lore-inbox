Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWEYDbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWEYDbM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 23:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWEYDbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 23:31:12 -0400
Received: from mail.suse.de ([195.135.220.2]:21480 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964837AbWEYDbL (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 23:31:11 -0400
From: Andi Kleen <ak@suse.de>
To: rohitseth@google.com
Subject: Re: [PATCH]:x86_64: Change assembly to use regular cpuid_count macro
Date: Thu, 25 May 2006 05:28:47 +0200
User-Agent: KMail/1.9.1
Cc: Linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <1148509522.14025.7.camel@galaxy.corp.google.com>
In-Reply-To: <1148509522.14025.7.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605250528.47736.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 May 2006 00:25, Rohit Seth wrote:
> Minor cleanup patch:  
> 
> Replacing the asm statement with cpuid_count macro(which already
> provides the same functionality).

Applied. Thanks.
-Andi
