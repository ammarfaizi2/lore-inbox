Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262473AbUKDW6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbUKDW6w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 17:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbUKDWzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:55:55 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:10245 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S262461AbUKDWwK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 17:52:10 -0500
Date: Thu, 4 Nov 2004 22:52:05 +0000
From: John Levon <levon@movementarian.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Jack Steiner <steiner@sgi.com>,
       linux-kernel@vger.kernel.org, edwardsg@sgi.com, dipankar@in.ibm.com
Subject: Re: contention on profile_lock
Message-ID: <20041104225205.GA57547@compsoc.man.ac.uk>
References: <200411021152.16038.jbarnes@engr.sgi.com> <200411041355.27228.jbarnes@engr.sgi.com> <20041104222122.GA55794@compsoc.man.ac.uk> <200411041427.05745.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411041427.05745.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Graham Coxon - Happiness in Magazines
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CPqSb-000PKT-Q9*MwXphpv6j5E*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 02:27:05PM -0800, Jesse Barnes wrote:

> Nope, not at all, just the locking :).  How does this one look?  I think I've 
> exported the right symbols.

Looks fine to me

regards
john
