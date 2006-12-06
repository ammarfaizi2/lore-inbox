Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936456AbWLFQlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936456AbWLFQlX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 11:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936399AbWLFQlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 11:41:23 -0500
Received: from ns2.suse.de ([195.135.220.15]:39280 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936456AbWLFQlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 11:41:22 -0500
Date: Wed, 6 Dec 2006 17:41:21 +0100
From: Jan Blunck <jblunck@suse.de>
To: Andreas Schwab <schwab@suse.de>
Cc: Phil Endecott <phil_arcwk_endecott@chezphil.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Subtleties of __attribute__((packed))
Message-ID: <20061206164120.GB4942@hasse.suse.de>
References: <4de7f8a60612060704k7d7c1ea3o1d43bee6c5e372d4@mail.gmail.com> <1165418558832@dmwebmail.belize.chezphil.org> <20061206155439.GA6727@hasse.suse.de> <jewt55c8rj.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jewt55c8rj.fsf@sykes.suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, Andreas Schwab wrote:

> Jan Blunck <jblunck@suse.de> writes:
> 
> > Maybe the arm backend is somehow broken.
> 
> A packed structure is something quite different than a structure of packed
> members.
> 

Well, right ... and where do you see a structure of packed members?

http://gcc.gnu.org/onlinedocs/gcc-4.1.1/gcc/Type-Attributes.html#Type-Attributes
