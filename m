Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314442AbSEPQtg>; Thu, 16 May 2002 12:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314446AbSEPQtf>; Thu, 16 May 2002 12:49:35 -0400
Received: from cpe-24-221-106-102.az.sprintbbd.net ([24.221.106.102]:48044
	"HELO farnsworth.org") by vger.kernel.org with SMTP
	id <S314442AbSEPQtd>; Thu, 16 May 2002 12:49:33 -0400
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Thu, 16 May 2002 09:49:26 -0700
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Still no ramfs usage limits in 2.5.9 or 2.4.19-pre8
Message-ID: <20020516164926.GA16670@farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson produced a patch about 18 months ago that added usage limits
to ramfs.  <http://ozlabs.org/people/dgibson/dwg-ramfs.patch>

Through 2.4.10, the AC kernel series carried this patch.

Linus' kernel from 2.4.11 onward adopted only one line from the
patch, the following attribution comment:
	"Usage limits added by David Gibson, Linuxcare Australia."

The usage limit code is missing, however.

Was this a simple mistake that has been overlooked?  Or are there
drawbacks to applying the patch that keep it out of the mainstream
kernels?

-Dale Farnsworth
