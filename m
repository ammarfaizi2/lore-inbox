Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268052AbTBMO2o>; Thu, 13 Feb 2003 09:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268053AbTBMO2o>; Thu, 13 Feb 2003 09:28:44 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:53146 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S268052AbTBMO2n>;
	Thu, 13 Feb 2003 09:28:43 -0500
Date: Thu, 13 Feb 2003 14:34:19 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NO BOOT since 2.5.60-bk1
Message-ID: <20030213143419.GA32527@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Thomas Schlichter <schlicht@uni-mannheim.de>,
	linux-kernel@vger.kernel.org
References: <200302131507.37380.schlicht@uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302131507.37380.schlicht@uni-mannheim.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2003 at 03:07:32PM +0100, Thomas Schlichter wrote:

 > I've got a problem booting the linux kernel 2.5.60-bk1 and -bk2. 2.5.60 works 
 > with no problems! The last messages before halting are (hand copied):
 > 
 > VFS: Mounted root (reiserfs filesystem) readonly.
 > Freeing unused kernel memory: 220k freed
 > INIT: version 2.78 booting

Is it a solid hang, or does the keyboard still work?
If so, alt-scrolllock will get you an EIP of where its hanging/looping.

	Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
