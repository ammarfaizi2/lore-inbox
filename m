Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbVHXUVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbVHXUVy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 16:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbVHXUVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 16:21:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39079 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932122AbVHXUVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 16:21:53 -0400
Date: Wed, 24 Aug 2005 16:21:33 -0400
From: Dave Jones <davej@redhat.com>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] cpu_exclusive sched domains on partial nodes temp fix
Message-ID: <20050824202133.GA10685@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Paul Jackson <pj@sgi.com>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <200508240401.j7O41qlB029277@hera.kernel.org> <20050824190651.GA10586@redhat.com> <20050824121340.3edf79d8.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050824121340.3edf79d8.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 12:13:40PM -0700, Paul Jackson wrote:

 > I'm still a couple of hours from actually verifying that ppc64 builds with
 > this - due to unrelated confusions on my end.  Perhaps you or Mackerras will
 > report in first, to verify if this patch works as advertised.

It does build, but I'm unable to boot test it.

		Dave

