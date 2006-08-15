Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965284AbWHOH5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965284AbWHOH5T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 03:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965286AbWHOH5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 03:57:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:44977 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965284AbWHOH5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 03:57:18 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: annotate FIX_STACK() and the rest of nmi()
Date: Tue, 15 Aug 2006 09:57:07 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Jan Beulich <jbeulich@novell.com>
References: <200608141658_MC3-1-C818-892D@compuserve.com>
In-Reply-To: <200608141658_MC3-1-C818-892D@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608150957.07369.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 August 2006 22:56, Chuck Ebbert wrote:
> In i386's entry.S, FIX_STACK() needs annotation because it
> replaces the stack pointer.  And the rest of nmi() needs
> annotation in order to compile with these new annotations.

Added thanks.
-Andi
