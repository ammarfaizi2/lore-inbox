Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWACOXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWACOXT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 09:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWACOXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 09:23:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56714 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751431AbWACOXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 09:23:18 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060103113059.GC24131@hasse.suse.de> 
References: <20060103113059.GC24131@hasse.suse.de> 
To: Jan Blunck <jblunck@suse.de>
Cc: akpm@osdl.org, dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Remove unnecessary __attribute__ ((packed)) 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Tue, 03 Jan 2006 14:23:02 +0000
Message-ID: <30332.1136298182@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jan Blunck <jblunck@suse.de> wrote:

> Remove the unnecessary __attribute__ ((packed)) since the enum itself is
> packed and not the location of it in the structure.

Fair enough.

David
