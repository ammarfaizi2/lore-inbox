Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWFRXXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWFRXXS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 19:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWFRXXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 19:23:18 -0400
Received: from dew1.atmos.washington.edu ([128.95.89.41]:35791 "EHLO
	dew1.atmos.washington.edu") by vger.kernel.org with ESMTP
	id S1751175AbWFRXXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 19:23:17 -0400
Message-ID: <4495E057.5000803@atmos.washington.edu>
Date: Sun, 18 Jun 2006 16:23:03 -0700
From: Harry Edmon <harry@atmos.washington.edu>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
References: <4492D5D3.4000303@atmos.washington.edu>	<20060617153511.53a129a3.akpm@osdl.org>	<44948EF6.1060201@atmos.washington.edu> <20060617165611.2c478723.akpm@osdl.org> <4494C592.6090601@osdl.org>
In-Reply-To: <4494C592.6090601@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.599 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:

>>   
> Does this fix it?
>    # sysctl -w net.ipv4.tcp_abc=0

Thanks for the suggestion.  I will give it a try later tonight.  Also Andrew - 
sorry for the incorrect placement of my follow-up comments.  I do appreciate 
everyone's help in figuring this out.

-- 
  Dr. Harry Edmon			E-MAIL: harry@atmos.washington.edu
  206-543-0547				harry@u.washington.edu
  Dept of Atmospheric Sciences		FAX:	206-543-0308
  University of Washington, Box 351640, Seattle, WA 98195-1640
