Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263693AbTDIT1A (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 15:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263698AbTDIT1A (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 15:27:00 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:34061 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263693AbTDIT07 (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 15:26:59 -0400
Date: Wed, 9 Apr 2003 20:38:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: davidm@hpl.hp.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: bk pull
Message-ID: <20030409203836.A9397@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, davidm@hpl.hp.com,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <200304091927.h39JRob0010157@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304091927.h39JRob0010157@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Wed, Apr 09, 2003 at 12:27:50PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 09, 2003 at 12:27:50PM -0700, David Mosberger wrote:
> Hi Linus,
> 
> please do a
> 
> 	bk pull http://lia64.bkbits.net/to-linus-2.5
> 
> This will update the files shown below.

Btw, do you have any plans to push the changes outside from arch/ia64
and include/asm-ia64/ in the ia64 patch to Linus? It would be really
nice if the ia64 port could be used with an out-of-the-box kernel.
