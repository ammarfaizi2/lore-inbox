Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263088AbUD2DWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUD2DWq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 23:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbUD2DWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 23:22:46 -0400
Received: from mail41-s.fg.online.no ([148.122.161.41]:31725 "EHLO
	mail41-s.fg.online.no") by vger.kernel.org with ESMTP
	id S263088AbUD2DWY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 23:22:24 -0400
From: Kenneth =?iso-8859-1?q?Aafl=F8y?= <keaafloy@online.no>
To: linux-kernel@vger.kernel.org
Subject: Re: Upgrading to 2.6 from Debian Woody (Was: No Subject)
Date: Thu, 29 Apr 2004 05:22:22 +0200
User-Agent: KMail/1.6.2
References: <S263020AbUD2DDO/20040429030314Z+1040@vger.kernel.org>
In-Reply-To: <S263020AbUD2DDO/20040429030314Z+1040@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404290522.22634.keaafloy@online.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 April 2004 05:03, whitehorse@mustika.net wrote:
>  I have a problem in compiling kernel 2.6.4 from kernel 2.4.19. I use
>  Debian woody. When I rebooting new kernel, some message occur such:
>  "modprobe: QM_MODULES: function not implemented"
>  and I can't load my modules when boot. I would like to waiting any one who
>  answer this. Please send to this mail. Thanks

I bet your problems would be solved by upgrading your dist to sid, as woody is 
pretty old, and does not contain the all the fixes in sid. Although I could 
be wrong, and all your troubles might be solved by a 'apt-get install 
modules-init-tools', in any case it is you distribution that is the problem, 
not the linux kernel, so please report this to the appropriate mailing list 
or support forum.

Another point would be that this is really a distribuition problem, and 
usually is solved by searching the appriopriate mailing list or forum.

Kenneth
