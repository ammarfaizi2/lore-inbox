Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318024AbSFSVkk>; Wed, 19 Jun 2002 17:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318025AbSFSVkj>; Wed, 19 Jun 2002 17:40:39 -0400
Received: from ns.suse.de ([213.95.15.193]:42502 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318024AbSFSVkf>;
	Wed, 19 Jun 2002 17:40:35 -0400
Date: Wed, 19 Jun 2002 23:40:35 +0200
From: Dave Jones <davej@suse.de>
To: Rudmer van Dijk <rvandijk@science.uva.nl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.23-dj2
Message-ID: <20020619234035.R29373@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Rudmer van Dijk <rvandijk@science.uva.nl>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20020619205136.GA18903@suse.de> <200206192133.g5JLXH814796@mail.science.uva.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200206192133.g5JLXH814796@mail.science.uva.nl>; from rvandijk@science.uva.nl on Wed, Jun 19, 2002 at 11:36:20PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 11:36:20PM +0200, Rudmer van Dijk wrote:
 > Ok I can run -dj2, but I cannot use X 8-( although this time no BUG or panic.

1, any agpgart related messages in the logs/dmesg ?
2. Can you disable agpgart, and try again. I'm fairly certain this
   is the cause, but just in case..

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
