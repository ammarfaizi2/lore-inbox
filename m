Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266074AbUFIKHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266074AbUFIKHJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 06:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266088AbUFIKHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 06:07:07 -0400
Received: from [213.146.154.40] ([213.146.154.40]:32130 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266084AbUFIKGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 06:06:39 -0400
Date: Wed, 9 Jun 2004 11:06:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Increasing number of inodes after format?
Message-ID: <20040609100638.GA18476@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Kara <jack@suse.cz>, Timothy Miller <miller@techsource.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <40C62F2F.4090801@techsource.com> <20040609094217.GA14564@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040609094217.GA14564@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 11:42:18AM +0200, Jan Kara wrote:
>   ReiserFS also does not have any particular limit on the number of inodes
> (because it actually does not have any ;).

they're just called stat_data in reiserfs.
