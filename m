Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263098AbTJZNBK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 08:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbTJZNBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 08:01:10 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35337 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263098AbTJZNBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 08:01:08 -0500
Date: Sun, 26 Oct 2003 13:00:58 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com, daniel@osdl.org,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org, pbadari@us.ibm.com
Subject: Re: Patch for Retry based AIO-DIO (Was AIO and DIOtestingon2.6.0-test7-mm1)
Message-ID: <20031026130058.A1125@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com, daniel@osdl.org,
	linux-aio@kvack.org, linux-kernel@vger.kernel.org,
	pbadari@us.ibm.com
References: <20031023104923.GA11543@in.ibm.com> <20031023135030.GA11807@in.ibm.com> <20031023155937.41b0eeda.akpm@osdl.org> <20031023232006.GH21490@fs.tum.de> <20031023162539.0051249d.akpm@osdl.org> <20031023233700.GJ21490@fs.tum.de> <20031023164638.5c32b80f.akpm@osdl.org> <20031026115719.GA10333@fs.tum.de> <20031026120808.D25595@flint.arm.linux.org.uk> <20031026121742.GC10333@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031026121742.GC10333@fs.tum.de>; from bunk@fs.tum.de on Sun, Oct 26, 2003 at 01:17:42PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 26, 2003 at 01:17:42PM +0100, Adrian Bunk wrote:
> With this patch ARM should default to -Os.
> 
> Could you recheck whether it really doesn't work?

Ok, I agree.  Didn't read the patch correctly.

(Still building test9 here so actually checking is completely out of
the question.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
