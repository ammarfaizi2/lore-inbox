Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312305AbSCUAGW>; Wed, 20 Mar 2002 19:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312306AbSCUAGM>; Wed, 20 Mar 2002 19:06:12 -0500
Received: from ns.suse.de ([213.95.15.193]:50438 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312305AbSCUAGA>;
	Wed, 20 Mar 2002 19:06:00 -0500
Date: Thu, 21 Mar 2002 01:05:59 +0100
From: Dave Jones <davej@suse.de>
To: david@shepard.tc
Cc: linux-kernel@vger.kernel.org
Subject: Re: smbfs font corruption in 2.5.7
Message-ID: <20020321010559.C30820@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>, david@shepard.tc,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020320233806.684.qmail@www4.nameplanet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 11:38:06PM -0000, david@shepard.tc wrote:
 > It appears there were some changes made during 2.5.6 to allow for smbfs unicode
 > support. The problem appears any time I mount an smb filesystem, whether in X or
 > at VGA framebuffer console. File and directory names show up in a language I
 > don't speak. Is there some setting I should change to support unicode now, or is
 > this a known problem. I haven't seen this reported yet, so...

Have you tried the "Use a default NLS" option, and then setting the
codepage to something else ?

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
