Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272276AbTHNQlP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 12:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272415AbTHNQlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 12:41:15 -0400
Received: from code.and.org ([63.113.167.33]:26289 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id S272276AbTHNQlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 12:41:08 -0400
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [RFC] file extents for EXT3
References: <m3ptjcabey.fsf@bzzz.home.net> <3F3791C8.4090903@pobox.com>
	<20030811095518.T7752@schatzie.adilger.int>
	<3F37C2EB.5050503@pobox.com> <20030813043218.GC1244@think>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 14 Aug 2003 12:41:01 -0400
In-Reply-To: <20030813043218.GC1244@think>
Message-ID: <m31xvombtu.fsf@code.and.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o <tytso@mit.edu> writes:

> I would like to add "no journal" support to ext3, and then rename it
> to ext2.  At some level, the only reason why we called it ext3 was
> mainly for the code stability issue.  (Well, that and in case people
> wanted a slightly smaller variant of ext2/3 --- but the people who
> care about size issues will likely be in embedded applications, and in
> those applications they will probably want to use something like jffs2
> anyway.)

 I presume that this option to ext3 would also restore the ext2
behaviour for fsync()?

-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null
