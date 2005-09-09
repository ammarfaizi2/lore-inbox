Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbVIIJ2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbVIIJ2B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbVIIJ2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:28:00 -0400
Received: from cantor2.suse.de ([195.135.220.15]:23486 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030188AbVIIJ16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:27:58 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.13]  x86_64: Fix incorrect FP signals
Date: Fri, 9 Sep 2005 11:27:52 +0200
User-Agent: KMail/1.8
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200509090127_MC3-1-A998-1B0D@compuserve.com>
In-Reply-To: <200509090127_MC3-1-A998-1B0D@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509091127.53219.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 September 2005 07:25, Chuck Ebbert wrote:
> This is the same patch that went into i386 just before 2.6.13
> came out.  I still can't build 64-bit user apps, so I tested
> with program (see below) in 32-bit mode on 64-bit kernel:

Applied thanks.

-Andi
