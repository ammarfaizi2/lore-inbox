Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262890AbVG2WTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262890AbVG2WTE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 18:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262880AbVG2WRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 18:17:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19135 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262904AbVG2WPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 18:15:23 -0400
Date: Fri, 29 Jul 2005 18:15:18 -0400
From: Dave Jones <davej@redhat.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: i387 floating-point test program/benchmark
Message-ID: <20050729221518.GB20253@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200507291639_MC3-1-A5E6-856D@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507291639_MC3-1-A5E6-856D@compuserve.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2005 at 04:36:05PM -0400, Chuck Ebbert wrote:
 > 			memset(&cpuset, sizeof(cpuset), 0);

This bug is like a disease, I swear.
(swapped args)

		Dave

