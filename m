Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319190AbSH2L1H>; Thu, 29 Aug 2002 07:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319191AbSH2L1H>; Thu, 29 Aug 2002 07:27:07 -0400
Received: from ns.suse.de ([213.95.15.193]:15622 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S319190AbSH2L1G>;
	Thu, 29 Aug 2002 07:27:06 -0400
Date: Thu, 29 Aug 2002 13:31:28 +0200
From: Dave Jones <davej@suse.de>
To: Jordan Breeding <jordan.breeding@attbi.com>
Cc: linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: Problems with 2.5.23-mm1
Message-ID: <20020829133128.C24918@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Jordan Breeding <jordan.breeding@attbi.com>,
	linux-kernel@vger.kernel.org, mochel@osdl.org
References: <3D6DCEC1.7020102@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D6DCEC1.7020102@attbi.com>; from jordan.breeding@attbi.com on Thu, Aug 29, 2002 at 02:35:29AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 02:35:29AM -0500, Jordan Breeding wrote:
 > Hello,
 > 
 > Another problem I am having is that I get this 
 > message on bootup: "mtrr: SMP support incomplete for this vendor".  It 
 > seems that this would be a problem however the box works fine as far as 
 > I can tell.  Thanks for any light anyone can shed on any of this and 
 > please let me know whether anyone needs to know more about this box 

Patrick Mochel (author of new mtrr driver) added to Cc:
What CPUs are in this system ?

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
