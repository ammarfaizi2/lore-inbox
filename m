Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291233AbSAaSnK>; Thu, 31 Jan 2002 13:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291230AbSAaSmx>; Thu, 31 Jan 2002 13:42:53 -0500
Received: from ns.suse.de ([213.95.15.193]:16907 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S291228AbSAaSmj>;
	Thu, 31 Jan 2002 13:42:39 -0500
Date: Thu, 31 Jan 2002 19:42:37 +0100
From: Dave Jones <davej@suse.de>
To: Tim Sullivan <tsullivan@datawest.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BusLogic build error in 2.5.3
Message-ID: <20020131194237.B10343@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Tim Sullivan <tsullivan@datawest.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1012501663.1349.20.camel@prostock.ecom-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1012501663.1349.20.camel@prostock.ecom-tech.com>; from tsullivan@datawest.net on Thu, Jan 31, 2002 at 11:27:42AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 11:27:42AM -0700, Tim Sullivan wrote:
 > According to a note in the scsi_obsolete.c file, "Once the last
 > driver uses the new code this *ENTIRE* file will be nuked."
 > It seems that scsi_obsolete.c has been "nuked" prematurely :)

 Perhaps the was the hope a preemptive nuke would push the
 maintainer / someone who cared about the driver to fix it up 8-)
 Randy Dunlap's 2.5 page has a list of the steps needed iirc.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
