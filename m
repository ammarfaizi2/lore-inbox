Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285065AbRLFJRB>; Thu, 6 Dec 2001 04:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285064AbRLFJQl>; Thu, 6 Dec 2001 04:16:41 -0500
Received: from weta.f00f.org ([203.167.249.89]:22468 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S285063AbRLFJQi>;
	Thu, 6 Dec 2001 04:16:38 -0500
Date: Thu, 6 Dec 2001 22:18:36 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas
Message-ID: <20011206091836.GA5470@weta.f00f.org>
In-Reply-To: <E16BkER-0006J0-00@wagner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16BkER-0006J0-00@wagner>
User-Agent: Mutt/1.3.24i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 09:09:35AM +1100, Rusty Russell wrote:

    The following patch implements convenient per-cpu areas:
        DECLARE_PER_CPU(int myvar);

Where or why do we need this?


   --cw
