Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277528AbRJERsa>; Fri, 5 Oct 2001 13:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277527AbRJERsU>; Fri, 5 Oct 2001 13:48:20 -0400
Received: from mplsdslgw14poolA71.mpls.uswest.net ([63.229.192.71]:54096 "EHLO
	bear.iucha.org") by vger.kernel.org with ESMTP id <S277472AbRJERsJ>;
	Fri, 5 Oct 2001 13:48:09 -0400
Date: Fri, 5 Oct 2001 12:48:37 -0500
From: iuchaflorin@qwest.net
To: linux-kernel@vger.kernel.org
Subject: kswapd <defunct> and in Z state
Message-ID: <20011005124837.A446@bear.iucha.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happened with linux-2.4.11-pre3-xfs on a debian woody K6-III/500 with
512 MB RAM.

I was downloading a ISO image, md5summing another while browsing the web 
and md5sum core dumped. I started another and a top and then I saw kswapd 
being defunct. The box oopsed a little later and when I get home I will post
the oops.

This is my third oops this day. Before that I had linux-2.4.10-xfs with an
uptime of 6 days.

florin

-- 

"If it's not broken, let's fix it till it is."

41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
