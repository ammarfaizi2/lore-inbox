Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268570AbRHFNyh>; Mon, 6 Aug 2001 09:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268576AbRHFNy1>; Mon, 6 Aug 2001 09:54:27 -0400
Received: from weta.f00f.org ([203.167.249.89]:61584 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S268570AbRHFNyO>;
	Mon, 6 Aug 2001 09:54:14 -0400
Date: Tue, 7 Aug 2001 01:55:09 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: /proc/<n>/maps getting _VERY_ long
Message-ID: <20010807015509.A24099@weta.f00f.org>
In-Reply-To: <20010807002320.A23937@weta.f00f.org> <E15TkGC-0000z3-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15TkGC-0000z3-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2001 at 02:17:32PM +0100, Alan Cox wrote:

    mmap nothing over a large space

shouldn't the rlimit be in the mmap?
(or are sparse mappings not supposed to count towards the rlimit?)



  --cw
