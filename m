Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267265AbUBMWqX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 17:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267269AbUBMWqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 17:46:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:22194 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267265AbUBMWpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 17:45:35 -0500
Date: Fri, 13 Feb 2004 14:38:21 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Michael Frank <mhf@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH, RFC: Version 2 of 2.6 Codingstyle
Message-Id: <20040213143821.663edcae.rddunlap@osdl.org>
In-Reply-To: <200402131638.17800.mhf@linuxmail.org>
References: <200402130615.10608.mhf@linuxmail.org>
	<200402131638.17800.mhf@linuxmail.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Feb 2004 16:49:30 +0800 Michael Frank <mhf@linuxmail.org> wrote:

| --- Documentation/CodingStyle.mhf.orig.1	2004-02-13 06:05:11.000000000 +0800
| +++ Documentation/CodingStyle	2004-02-13 16:42:07.000000000 +0800
|  
|  		Chapter 2: Breaking long lines and strings
|  
| -
| -Long strings are broken into smaller strings too.
| +Descendant's are always shorter than the parent and are placed substantially
*  Descendants  (plural, not possessive)

| +to the right. The same applies to function headers with a long argument list.
| +Long strings are as well broken into smaller strings.


| +4) forgetting about sideeffects. Macros defining expressions must enclose the
* <sideeffects> : it's still not one word.

| +expression in parenthesis. Note that this does not eliminate all side effects.
*                parentheses


--
~Randy
