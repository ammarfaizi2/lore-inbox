Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWBRWMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWBRWMc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 17:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWBRWMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 17:12:32 -0500
Received: from cantor2.suse.de ([195.135.220.15]:58080 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932242AbWBRWMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 17:12:31 -0500
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild:
References: <20060217214855.GA5563@mars.ravnborg.org>
From: Andi Kleen <ak@suse.de>
Date: 18 Feb 2006 23:12:28 +0100
In-Reply-To: <20060217214855.GA5563@mars.ravnborg.org>
Message-ID: <p73y80848qb.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:

> I have moved the functionality of reference_init + reference_discarded
> to modpost to secure a much wider use of this check.

How much does that slow the build down?

-Andi
