Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261379AbREQJSb>; Thu, 17 May 2001 05:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261380AbREQJSW>; Thu, 17 May 2001 05:18:22 -0400
Received: from ns.suse.de ([213.95.15.193]:6666 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S261379AbREQJSI>;
	Thu, 17 May 2001 05:18:08 -0400
Date: Thu, 17 May 2001 11:17:45 +0200
From: Karsten Keil <kkeil@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: patch-2.2.19.gz
Message-ID: <20010517111745.A11559@pingi.muc.suse.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3B032598.79716F72@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3B032598.79716F72@mindspring.com>; from joeja@mindspring.com on Wed, May 16, 2001 at 09:12:56PM -0400
Organization: SuSE Muenchen GmbH
X-Operating-System: Linux 2.2.18-SMP i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2001 at 09:12:56PM -0400, Joe wrote:
> I just patched my 2.2.18 kernel.  After I did a make dep I got the
> following message.  Any ideas what does this mean?
> 
> md5sum: WARNING: 11 of 12 computed checksums did NOT match
> 
ignore.
It's simple that one file with md5sums was not updated in the isdn driver.

-- 
Karsten Keil
SuSE Labs
ISDN development
