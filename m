Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVFBTHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVFBTHZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 15:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVFBTHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 15:07:25 -0400
Received: from fmr23.intel.com ([143.183.121.15]:29146 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261249AbVFBTHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 15:07:21 -0400
Date: Thu, 2 Jun 2005 12:06:44 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: YhLu <YhLu@tyan.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5 is broken in nvidia Ck804 Opteron MB/with dual cor e dual way
Message-ID: <20050602120643.A13650@unix-os.sc.intel.com>
References: <3174569B9743D511922F00A0C94314230A403970@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3174569B9743D511922F00A0C94314230A403970@TYANWEB>; from YhLu@tyan.com on Thu, Jun 02, 2005 at 11:56:25AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 11:56:25AM -0700, YhLu wrote:
> 
>    Really?,  smp_num_siblings is global variable and initially is set 1.
> 
>    YH
> 
But detect_ht() can override it.. thats just the start value.

try cscope :-)

Cheers,
ashok
