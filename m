Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310960AbSCMS2C>; Wed, 13 Mar 2002 13:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310964AbSCMS1x>; Wed, 13 Mar 2002 13:27:53 -0500
Received: from ns.suse.de ([213.95.15.193]:42763 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310960AbSCMS1n>;
	Wed, 13 Mar 2002 13:27:43 -0500
Date: Wed, 13 Mar 2002 19:27:42 +0100
From: Dave Jones <davej@suse.de>
To: Francois Baligant <francois@ops.be.wanadoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.19-pre3 locks solid at boot for Intel machine check
Message-ID: <20020313192742.C10137@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Francois Baligant <francois@ops.be.wanadoo.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0203131906510.23034-100000@speedy.noc.euronet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0203131906510.23034-100000@speedy.noc.euronet.be>; from francois@ops.be.wanadoo.com on Wed, Mar 13, 2002 at 07:07:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 07:07:51PM +0100, Francois Baligant wrote:
 > Intel machine check architecture supported. 
 > 
 >         Is this a know problem ? 

 Yes. I goofed. Back out the changes to bluesmoke.c and all will be well.
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
