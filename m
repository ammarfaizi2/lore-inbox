Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312896AbSDSO4S>; Fri, 19 Apr 2002 10:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312901AbSDSO4R>; Fri, 19 Apr 2002 10:56:17 -0400
Received: from ns.suse.de ([213.95.15.193]:28689 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312896AbSDSO4R>;
	Fri, 19 Apr 2002 10:56:17 -0400
Date: Fri, 19 Apr 2002 16:56:15 +0200
From: Dave Jones <davej@suse.de>
To: Jan Slupski <jslupski@email.com>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: [PATCH] Wrong IRQ for USB on Sony Vaio (dmi_scan.c, pci-irq.c)
Message-ID: <20020419165615.A23782@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Jan Slupski <jslupski@email.com>, linux-kernel@vger.kernel.org,
	alan@redhat.com
In-Reply-To: <20020419164048.H15517@suse.de> <Pine.LNX.4.21.0204191636290.8479-100000@venus.ci.uw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2002 at 04:43:15PM +0200, Jan Slupski wrote:

 > Do you know any simple tool to retrieve DMI information?

http://people.redhat.com/arjanv/dmidecode.c

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
