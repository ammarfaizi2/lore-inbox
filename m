Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272287AbTHII64 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 04:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272288AbTHII64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 04:58:56 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:39139
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272287AbTHII6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 04:58:55 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]O14int
Date: Sat, 9 Aug 2003 19:04:19 +1000
User-Agent: KMail/1.5.3
Cc: Cliff White <cliffw@osdl.org>
References: <200308090149.25688.kernel@kolivas.org>
In-Reply-To: <200308090149.25688.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308091904.19222.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Aug 2003 01:49, Con Kolivas wrote:
> More duck tape interactivity tweaks

s/duck/duct

> Wli pointed out an error in the nanosecond to jiffy conversion which may
> have been causing too easy to migrate tasks on smp (? performance change).

Looks like I broke SMP build with this. Will fix soon; don't bother trying 
this on SMP yet.

Con

