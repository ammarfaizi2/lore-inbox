Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272473AbTGZMhZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 08:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272474AbTGZMhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 08:37:25 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:20423 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S272473AbTGZMhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 08:37:24 -0400
Date: Sat, 26 Jul 2003 14:52:30 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: John Bradford <john@grabjohn.com>
Cc: rpjday@mindspring.com, linux-kernel@vger.kernel.org
Subject: Re: some kernel config menu suggested tweaks
Message-ID: <20030726125230.GC6560@louise.pinerecords.com>
References: <200307241910.h6OJAWnm000706@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307241910.h6OJAWnm000706@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [john@grabjohn.com]
> 
> The filesystem menu, for example, I could previously just skip down in
> make menuconfig, selecting and deselecting what I wanted.  Now, I have
> to go in and out, and in and out, just to see what's selected and
> what's not.  Sure, it might look nice to a new user who doesn't like
> to see a lot of options they don't necessarily understand, but it
> wastes the time of more experienced users.

I'll be sending a patch to fix up this horrid thing shortly.

-- 
Tomas Szepe <szepe@pinerecords.com>
