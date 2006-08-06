Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWHFLyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWHFLyi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 07:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWHFLyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 07:54:38 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:42943 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S1751372AbWHFLyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 07:54:37 -0400
Date: Sun, 6 Aug 2006 13:50:43 +0200
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Suspend on Dell D420
Message-ID: <20060806115043.GA30671@uio.no>
References: <20060804162300.GA26148@uio.no> <200608050126.57060.rjw@sisk.pl> <20060805082321.GB27129@uio.no> <200608051108.01180.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200608051108.01180.rjw@sisk.pl>
X-Operating-System: Linux 2.6.16trofastxen on a x86_64
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2006 at 11:08:00AM +0200, Rafael J. Wysocki wrote:
>> No idea whether it's related. FWIW, resume didn't work with maxcpus=1 on boot
>> either, so I'm not really sure how related it is.
> Hm, could you please try it with a non-SMP kernel?

Compiling straight 2.6.17 with CONFIG_SMP=n suspends and resumes just fine.

/* Steinar */
-- 
Homepage: http://www.sesse.net/
