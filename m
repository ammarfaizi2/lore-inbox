Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316372AbSFEUbc>; Wed, 5 Jun 2002 16:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316390AbSFEUbb>; Wed, 5 Jun 2002 16:31:31 -0400
Received: from ns.suse.de ([213.95.15.193]:19976 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316372AbSFEUba>;
	Wed, 5 Jun 2002 16:31:30 -0400
Date: Wed, 5 Jun 2002 22:31:31 +0200
From: Dave Jones <davej@suse.de>
To: Simon Turvey <turveysp@ntlworld.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Devfs and driverfs
Message-ID: <20020605223131.L16262@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Simon Turvey <turveysp@ntlworld.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <000901c20ccf$00baa230$030ba8c0@mistral>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 09:24:32PM +0100, Simon Turvey wrote:
 > I apologise if this is a trivial question but I was hoping someone could
 > explain or point me in the direction of more info.
 > 
 > I understand the purpose and reason for devfs but I cannot find any info on
 > driverfs.  What's it for?

driverfs is a 'view by connection' view of everything in the system.
It useful for a number of things, from Power management to hinv type
tools.  Read more at Documentation/driver-model.txt

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
