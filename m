Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbVINCWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbVINCWz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 22:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbVINCWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 22:22:54 -0400
Received: from xproxy.gmail.com ([66.249.82.202]:28471 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964962AbVINCWy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 22:22:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pIj3bKIwuJg4PD2k/Icd0cA6KKRwAlFQBrQycXTebjKcYZjmfdf6DvPDhtWDzuJiPrdGkDuL3JCiCM7P2VPTiiLvvyLkcAXMfalLJpPBtUOodohHeOqoM4cSvH54Ha426EluGMt0/sciDwLhQyR1XxLh6VlXLbTr0QuZRH0gF4Y=
Message-ID: <2ac89c70050913192218fce328@mail.gmail.com>
Date: Wed, 14 Sep 2005 06:22:49 +0400
From: Dmitrij Bogush <dmitrij.bogush@gmail.com>
Reply-To: dmitrij.bogush@gmail.com
To: "Randy.Dunlap" <rdunlap@xenotime.net>,
       Dmitrij Bogush <dmitrij.bogush@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: snd-via82xx-modem do not work from 2.6.12 kernel version
In-Reply-To: <20050914004243.GA10774@tecr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2ac89c70050913145926583918@mail.gmail.com>
	 <20050913235609.GB9531@tecr>
	 <Pine.LNX.4.50.0509131643010.3527-100000@shark.he.net>
	 <20050914004243.GA10774@tecr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Dmitrij, I guess you are using slmodem, be sure that you are with recent
> versions (http://linmodems.technion.ac.il).
> 
Eh.. sure I forget about slmodem update..  

Now it works, thanks.

-- 
Best Regards,
Dmitrij A Bogush.
