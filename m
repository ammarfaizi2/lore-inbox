Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318009AbSFSVGE>; Wed, 19 Jun 2002 17:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318010AbSFSVGD>; Wed, 19 Jun 2002 17:06:03 -0400
Received: from ns.suse.de ([213.95.15.193]:53008 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318009AbSFSVGC>;
	Wed, 19 Jun 2002 17:06:02 -0400
Date: Wed, 19 Jun 2002 23:06:03 +0200
From: Dave Jones <davej@suse.de>
To: Rudmer van Dijk <rvandijk@science.uva.nl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.23-dj2
Message-ID: <20020619230603.L29373@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Rudmer van Dijk <rvandijk@science.uva.nl>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20020619205136.GA18903@suse.de> <200206192059.g5JKxF806954@mail.science.uva.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200206192059.g5JKxF806954@mail.science.uva.nl>; from rvandijk@science.uva.nl on Wed, Jun 19, 2002 at 11:02:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 11:02:17PM +0200, Rudmer van Dijk wrote:

 > I was busy testing it with 2.5.23-dj1...
 > got a panic, but could not save the output (and did not liked the idea to 
 > write it all down 8), also I thought it had notinhg to do with the agpgart 
 > split and wanted to try to run 2.5.23-dj1 first before reporting... ah well 
 > will try it with -dj2

Chipset type and the output of "grep AGP .config" may be something to
begin with. Did it crash on load at boot time? or during agp usage?

        Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
