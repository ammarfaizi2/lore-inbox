Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261349AbSKXPPa>; Sun, 24 Nov 2002 10:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261354AbSKXPPa>; Sun, 24 Nov 2002 10:15:30 -0500
Received: from services.cam.org ([198.73.180.252]:57621 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S261349AbSKXPPa>;
	Sun, 24 Nov 2002 10:15:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: William Lee Irwin III <wli@holomorphy.com>
Subject: opps in kswapd
Date: Sun, 24 Nov 2002 10:21:54 -0500
User-Agent: KMail/1.4.3
Cc: akpm@digeo.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <25282B06EFB8D31198BF00508B66D4FA03EA5B14@fmsmsx114.fm.intel.com> <200211241001.27971.tomlins@cam.org> <20021124150039.GB18063@holomorphy.com>
In-Reply-To: <20021124150039.GB18063@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211241021.54957.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 24, 2002 10:00 am, William Lee Irwin III wrote:
> At some point in the past, I wrote:
> >> Okay, you've jumped into oblivion. What fs's were you using here?
>
> On Sun, Nov 24, 2002 at 10:01:27AM -0500, Ed Tomlinson wrote:
> > reiserfs.  (sorry about the subject line)
>
> Did you have CONFIG_HUGETLB_FS=y and/or the patch in this thread applied?

No.  hense the apology about the subject line (now updated).

Ed


