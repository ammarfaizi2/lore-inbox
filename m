Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965245AbVIICtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965245AbVIICtR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 22:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965250AbVIICtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 22:49:17 -0400
Received: from mx1.suse.de ([195.135.220.2]:45273 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965245AbVIICtP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 22:49:15 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.13] x86_64: Clean up nmi error message
Date: Fri, 9 Sep 2005 04:49:10 +0200
User-Agent: KMail/1.8
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200509082236_MC3-1-A99D-81DE@compuserve.com>
In-Reply-To: <200509082236_MC3-1-A99D-81DE@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509090449.10500.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 September 2005 04:33, Chuck Ebbert wrote:
> The x86_64 nmi code is missing a newline in one of its messages.
>
> I added a space before the CPU id for readability and killed the trailing
> space on the previous line as well.

Thanks merged.
-Andi
