Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932969AbWKLRNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932969AbWKLRNZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 12:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932970AbWKLRNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 12:13:25 -0500
Received: from smtp106.rog.mail.re2.yahoo.com ([68.142.225.204]:40790 "HELO
	smtp106.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932969AbWKLRNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 12:13:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:X-YMail-OSG:From:Organization:To:Subject:Date:User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=tj6Ak25s6+fT74MWQXUwgvqPouNNl/YuPR3m4l7fLUEZON+nQUKvJHViIg9PGDU9IghKMbOSLjleZAO3PCLfLo7oX6oDAkOGc73SiVBK8ZB6OYoDvmEGP6x2T1nLHgT+SSw1xTgLfBpH88sz8MZHsB53z19peib4lQXXGGECJUM=  ;
X-YMail-OSG: AFsdFrwVM1ko0dnv.fyTW0vjh1MeMRVTu2tP7xLTs4s3n2iJrx5gHeoFIbOgPr6ULYG4XTG_GKmWyBl.lTIoQ.rH6xwu_okpo5W4IvFdjtBHx.hD9CPDkvGYbiSeaVSOylAqdvmVvWrAZS9i_xpBi_QZvAmubD1V6Eo-
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: linux-kernel@vger.kernel.org
Subject: ieee80211 & ipw2200 (ipw2100) issues
Date: Sun, 12 Nov 2006 12:13:20 -0500
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611121213.20582.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to know when the Intel people working on the ipw2200 will merge 
1.2.0 into vanilla? If it's not in vanilla is this present in akpm's -mm 
tree?

The version in vanilla right now doesn't work with WPA and doesn't work with 
the newst firmware.  

Are there plans to change the ipw cards to use the new softmac subsystem? 

Thanks,
Shawn.
