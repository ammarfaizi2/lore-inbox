Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291472AbSBAB2a>; Thu, 31 Jan 2002 20:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291473AbSBAB2V>; Thu, 31 Jan 2002 20:28:21 -0500
Received: from ns.suse.de ([213.95.15.193]:56080 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S291472AbSBAB2M>;
	Thu, 31 Jan 2002 20:28:12 -0500
Date: Fri, 1 Feb 2002 02:28:07 +0100
From: Dave Jones <davej@suse.de>
To: Greg KH <greg@kroah.com>
Cc: Mark McClelland <mark@alpha.dyndns.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: ov511 verbose startup.
Message-ID: <20020201022807.J10343@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Greg KH <greg@kroah.com>, Mark McClelland <mark@alpha.dyndns.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20020131023457.D31313@suse.de> <20020131035936.GD31006@kroah.com> <3C58D69B.6000205@alpha.dyndns.org> <20020131053124.GI31006@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020131053124.GI31006@kroah.com>; from greg@kroah.com on Wed, Jan 30, 2002 at 09:31:24PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 09:31:24PM -0800, Greg KH wrote:
 > Dave, does this problem go away on 2.5.3-pre6?

 Great, heisenbug. Subsequent reboots under any kernel
 haven't managed to reproduce the problem.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
