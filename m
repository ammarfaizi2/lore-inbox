Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263212AbVGAEoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbVGAEoF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 00:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263215AbVGAEoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 00:44:05 -0400
Received: from siaag2af.compuserve.com ([149.174.40.136]:15234 "EHLO
	siaag2af.compuserve.com") by vger.kernel.org with ESMTP
	id S263212AbVGAEoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 00:44:02 -0400
Date: Fri, 1 Jul 2005 00:40:27 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Handle kernel page faults using task gate
To: eliad lubovsky <eliadl@013.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Message-ID: <200507010043_MC3-1-A32F-B78C@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Jul 2005 at 04:23:08 +0300, eliad lubovsky wrote:

> attached a patch, it may be more clear to understand what I have done.

Ouch.

Are you doublefaulting before you reach the handler?


--
Chuck
