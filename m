Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289054AbSBDVGU>; Mon, 4 Feb 2002 16:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289057AbSBDVGK>; Mon, 4 Feb 2002 16:06:10 -0500
Received: from ns.suse.de ([213.95.15.193]:17681 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289054AbSBDVGD>;
	Mon, 4 Feb 2002 16:06:03 -0500
Date: Mon, 4 Feb 2002 22:06:02 +0100
From: Dave Jones <davej@suse.de>
To: "Daniel E. Shipton" <dshipton@vrac.iastate.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-dj2
Message-ID: <20020204220602.E11789@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"Daniel E. Shipton" <dshipton@vrac.iastate.edu>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020204154800.A13519@suse.de> <1012841649.8335.6.camel@regatta> <20020204194719.C11789@suse.de> <1012854899.8333.12.camel@regatta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1012854899.8333.12.camel@regatta>; from dshipton@vrac.iastate.edu on Mon, Feb 04, 2002 at 02:34:58PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2002 at 02:34:58PM -0600, Daniel E. Shipton wrote:
 > close......that worked out....how about this one...
 > fs/fs.o: In function `init_iso9660_fs':
 > fs/fs.o(.text.init+0xdf1): undefined reference to `zisofs_cleanup'
 > make: *** [vmlinux] Error 1

 Hrmm, what are your .config options for ..
 CONFIG_ISO9660_FS, CONFIG_ZISOFS and CONFIG_ZISOFS_FS ?

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
