Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVI1SAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVI1SAK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 14:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbVI1SAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 14:00:10 -0400
Received: from newpeace.netnation.com ([204.174.223.7]:58564 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id S1750700AbVI1SAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 14:00:09 -0400
Date: Wed, 28 Sep 2005 11:00:07 -0700
From: Simon Kirby <sim@netnation.com>
To: Philippe Troin <phil@fifi.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strangeness with signals
Message-ID: <20050928180007.GA22836@netnation.com>
References: <20050927232034.GC6833@netnation.com> <87hdc6htur.fsf@ceramic.fifi.org> <20050928034659.GA27953@netnation.com> <873bnp5hxd.fsf@ceramic.fifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873bnp5hxd.fsf@ceramic.fifi.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2005 at 08:30:06AM -0700, Philippe Troin wrote:

> As long as sa_handler (or sa_sigaction) is not SIG_DFL (which is NULL
> on linux).

No, this is not the case.  This is why I provided the example.  I cannot
get it to work with sa_handler.

Simon-
