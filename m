Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290760AbSAaAN0>; Wed, 30 Jan 2002 19:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290759AbSAaANP>; Wed, 30 Jan 2002 19:13:15 -0500
Received: from ns.suse.de ([213.95.15.193]:32004 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290757AbSAaANF>;
	Wed, 30 Jan 2002 19:13:05 -0500
Date: Thu, 31 Jan 2002 01:13:02 +0100
From: Dave Jones <davej@suse.de>
To: Erik Andersen <andersen@codepoet.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020131011302.B31313@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020130211422.GA22705@codepoet.org> <E16W3no-0000Jv-00@the-village.bc.nu> <20020130234847.GA25577@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020130234847.GA25577@codepoet.org>; from andersen@codepoet.org on Wed, Jan 30, 2002 at 04:48:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 04:48:48PM -0700, Erik Andersen wrote:
 > > assumptions. See the NCR5380 stuff I've now all done (in 2.4.18pre) - dont 
 > > use 2.5.* NCR5380 it'll probably corrupt your system if it doesn't just die
 > > or hang - Linus apparently merged untested stuff to the old broken driver.
 > 
 > This is in the latest -ac kernels?

 Even better, it's in 2.4 mainline.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
