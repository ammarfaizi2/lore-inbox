Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267145AbSLDXhT>; Wed, 4 Dec 2002 18:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267146AbSLDXhT>; Wed, 4 Dec 2002 18:37:19 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:30204 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S267145AbSLDXhS>; Wed, 4 Dec 2002 18:37:18 -0500
Date: Wed, 4 Dec 2002 15:44:44 -0800
From: Chris Wright <chris@wirex.com>
To: Greg KH <greg@kroah.com>
Cc: linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] LSM fix for stupid "empty" functions - take 2
Message-ID: <20021204154444.A575@figure1.int.wirex.com>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-security-module@wirex.com,
	linux-kernel@vger.kernel.org
References: <20021201083056.GJ679@kroah.com> <20021204001322.GA23464@kroah.com> <20021204001438.B25613@figure1.int.wirex.com> <20021204230050.GB29519@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021204230050.GB29519@kroah.com>; from greg@kroah.com on Wed, Dec 04, 2002 at 03:00:50PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH (greg@kroah.com) wrote:
> On Wed, Dec 04, 2002 at 12:14:38AM -0800, Chris Wright wrote:
> > 
> > Also, I think the fixup should go directly in verify, since they are
> > always called together.  Otherwise, this looks good.  Thanks, it's been
> > sorely needed.
> 
> Thanks for the changes, I'll use your version of this :)

alright, thanks.
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
