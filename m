Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWHaFM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWHaFM4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 01:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbWHaFM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 01:12:56 -0400
Received: from hera.kernel.org ([140.211.167.34]:62896 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750800AbWHaFMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 01:12:55 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Linux v2.6.18-rc5
Date: Thu, 31 Aug 2006 01:14:52 -0400
User-Agent: KMail/1.8.2
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org> <20060827231421.f0fc9db1.akpm@osdl.org>
In-Reply-To: <20060827231421.f0fc9db1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608310114.52887.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 August 2006 02:14, Andrew Morton wrote:

> From: Johan Rutgeerts <johan.rutgeerts@mech.kuleuven.be>
> Subject: Acpi oops 2.6.17.7 vanilla

It turns out that this one has been with us since at least 2.6.15.
So far, seen only on Johan's machine.

http://bugzilla.kernel.org/show_bug.cgi?id=6980

So this one probably is not worthy of a 2.6.18 stopper list.

cheers,
-Len
