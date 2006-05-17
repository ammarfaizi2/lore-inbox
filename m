Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWEQPxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWEQPxi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 11:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWEQPxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 11:53:38 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:51591 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1750741AbWEQPxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 11:53:37 -0400
Date: Wed, 17 May 2006 11:53:35 -0400
To: George Nychis <gnychis@cmu.edu>
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org,
       linux-lvm@redhat.com
Subject: Re: need help booting from SATA in 2.4.32
Message-ID: <20060517155335.GF23933@csclub.uwaterloo.ca>
References: <446A36B8.1060707@cmu.edu> <20060516203917.GQ11191@w.ods.org> <446A418E.3070307@cmu.edu> <20060517034814.GA25818@w.ods.org> <446B2523.1040800@cmu.edu> <20060517133456.GD23933@csclub.uwaterloo.ca> <446B27E4.7040509@cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446B27E4.7040509@cmu.edu>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2006 at 09:40:52AM -0400, George Nychis wrote:
> Because it does......
> 
> on bootup the *same* exact drive in 2.4.32 shows up as /dev/hda
> 
> It has the exact same volume information as my drive that shows up in
> 2.6.9 as /dev/sda

Yes I do remember a few sata controllers had some support in 2.4, which
was dropped from 2.6 early on when libata came in.

It is very unlikely you will ever see that again in the future.

Len Sorensen
