Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266409AbUGBDGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266409AbUGBDGH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 23:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266423AbUGBDGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 23:06:07 -0400
Received: from holomorphy.com ([207.189.100.168]:13755 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266409AbUGBDGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 23:06:00 -0400
Date: Thu, 1 Jul 2004 20:05:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, mpm@selenic.com, paul@linuxaudiosystems.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.X, NPTL, SCHED_FIFO and JACK
Message-ID: <20040702030547.GI21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
	mpm@selenic.com, paul@linuxaudiosystems.com,
	linux-kernel@vger.kernel.org
References: <200406301341.i5UDfkKX010518@localhost.localdomain> <20040701180356.GI5414@waste.org> <20040701181401.GB21066@holomorphy.com> <20040701154554.30063e97.akpm@osdl.org> <20040702004538.GF21066@holomorphy.com> <40E4D08B.1070608@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40E4D08B.1070608@kolivas.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 01:03:39PM +1000, Con Kolivas wrote:
> My impetus for doing a policy rewrite was the recurring complaint that
> the 2.6 scheduler is currently too complicated for even basic
> scheduling. I see no point in trying to implement other changes until
> the framework for normal policies is in place that can be built on. I
> don't see even the policy rewrites as being appropriate for 2.6, let
> alone anything fancier. If we have something in place that more people
> than not agree is satisfactory for normal scheduling, then more can be
> added for 2.7+ development.

The point I had was really that what's going on is very minor.


-- wli
