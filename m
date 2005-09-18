Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbVIRK1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbVIRK1E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 06:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbVIRK1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 06:27:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:59620 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750883AbVIRK1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 06:27:01 -0400
Date: Sun, 18 Sep 2005 11:26:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: chriswhite@gentoo.org, Christoph Hellwig <hch@infradead.org>,
       Hans Reiser <reiser@namesys.com>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Message-ID: <20050918102658.GB22210@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
	Hans Reiser <reiser@namesys.com>,
	LKML <linux-kernel@vger.kernel.org>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <432AFB44.9060707@namesys.com> <200509171415.50454.vda@ilport.com.ua> <200509180934.50789.chriswhite@gentoo.org> <200509181321.23211.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509181321.23211.vda@ilport.com.ua>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2005 at 01:21:23PM +0300, Denis Vlasenko wrote:
> This is it. I do not say "accept reiser4 NOW", I am saying "give Hans
> good code review".

After he did his basic homework.  Note that reviewing hans code is probably
at the very end of everyones todo list because every critizm of his code
starts a huge flamewar where hans tries to attack everyone not on his
party line personally.

I've said I'm gonna do a proper review after he has done the basic homework,
which he seems to have half-done now at least.  Right now he hasn't finished
that and there's much more exciting filesystems like ocfs2 around that
are much easier to read and actually have developers that you can have
a reasonable conversation with.  (and that unlike hans actually try to
improve core code where it makes sense for them)
