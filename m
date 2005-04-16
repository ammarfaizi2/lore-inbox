Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262686AbVDPPhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbVDPPhm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 11:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbVDPPhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 11:37:42 -0400
Received: from jose.lug.udel.edu ([128.175.60.112]:45204 "HELO
	mail.lug.udel.edu") by vger.kernel.org with SMTP id S262686AbVDPPhh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 11:37:37 -0400
From: ross@lug.udel.edu
Date: Sat, 16 Apr 2005 11:37:37 -0400
To: Dave Airlie <airlied@gmail.com>
Cc: "ross@lug.udel.edu" <ross@lug.udel.edu>, linux-kernel@vger.kernel.org
Subject: Re: DRM not working with 2.6.11.5
Message-ID: <20050416153737.GA13373@jose.lug.udel.edu>
References: <20050416070925.GA1237@jose.lug.udel.edu> <21d7e99705041601476a147251@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e99705041601476a147251@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 16, 2005 at 06:47:13PM +1000, Dave Airlie wrote:
> You didn't load the agp chipset module..
> it would be nice if it happened automatically...

Spot on - thanks man.  Will update rc scripts from 2.4.  Thanks!

-- 
Ross Vandegrift
ross@lug.udel.edu

"The good Christian should beware of mathematicians, and all those who
make empty prophecies. The danger already exists that the mathematicians
have made a covenant with the devil to darken the spirit and to confine
man in the bonds of Hell."
	--St. Augustine, De Genesi ad Litteram, Book II, xviii, 37
