Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130487AbRDJRtm>; Tue, 10 Apr 2001 13:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130507AbRDJRtW>; Tue, 10 Apr 2001 13:49:22 -0400
Received: from ns.suse.de ([213.95.15.193]:29452 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130487AbRDJRtT>;
	Tue, 10 Apr 2001 13:49:19 -0400
Date: Tue, 10 Apr 2001 19:49:16 +0200
From: Andi Kleen <ak@suse.de>
To: gis88530 <gis88530@cis.nctu.edu.tw>
Cc: linux-kernel@vger.kernel.org
Subject: Re: memory usage
Message-ID: <20010410194916.A22380@gruyere.muc.suse.de>
In-Reply-To: <034201c0c1e5$adfc2b70$ae58718c@cis.nctu.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <034201c0c1e5$adfc2b70$ae58718c@cis.nctu.edu.tw>; from gis88530@cis.nctu.edu.tw on Wed, Apr 11, 2001 at 01:42:55AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2001 at 01:42:55AM +0800, gis88530 wrote:
> Hello,
> 
> I can use "ps" to see memory usage of daemons and user programs.
> I can't find any memory information of kernel with "top" and "ps".
> 
> Do you know how to take memory usage information of kernel ?

Try cat /proc/slabinfo


-Andi
