Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293258AbSCGLbh>; Thu, 7 Mar 2002 06:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293162AbSCGLbS>; Thu, 7 Mar 2002 06:31:18 -0500
Received: from ns.suse.de ([213.95.15.193]:64772 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292294AbSCGLbG>;
	Thu, 7 Mar 2002 06:31:06 -0500
Date: Thu, 7 Mar 2002 12:30:59 +0100
From: Dave Jones <davej@suse.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Woodhouse <dwmw2@infradead.org>,
        Jeff Dike <jdike@karaya.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages
Message-ID: <20020307123058.B27659@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Woodhouse <dwmw2@infradead.org>, Jeff Dike <jdike@karaya.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Benjamin LaHaise <bcrl@redhat.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <505.1015411792@redhat.com> <E16iecJ-0007Nn-00@the-village.bc.nu> <20020306222149.GC370@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020306222149.GC370@elf.ucw.cz>; from pavel@ucw.cz on Wed, Mar 06, 2002 at 11:21:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2002 at 11:21:50PM +0100, Pavel Machek wrote:
 > I just imagined hardware which supports freeing memory -- just do not
 > refresh it any more to conserve power ;-))).
 > Granted, it would probably only make sense in big chunks, like 2MB or
 > so... It might make sense for a PDA...

 ISTR reading about one handheld that did something like this (possibly psion)
 The hardware has the ability to migrate data from one memory bank to
 another and power down the least used one.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
