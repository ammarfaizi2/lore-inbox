Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbVKUVyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbVKUVyl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVKUVyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:54:41 -0500
Received: from web34115.mail.mud.yahoo.com ([66.163.178.113]:45219 "HELO
	web34115.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751096AbVKUVyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:54:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=1Kq2bXD29SXAFA9JRozSAm/jtqtU1OGoppePDZoE6lAUdBYoV1UCE4B+oKwGjIqYd5mDQOU6vsvszAHfv+k+EymVLr9Jk2Oi/7aNy+umopSzbqHtVCh4stMLNVSvY7yKbO8eBCUAhl8PP2TjCoog3+iG916agWlLj++GduzH1Do=  ;
Message-ID: <20051121215439.67346.qmail@web34115.mail.mud.yahoo.com>
Date: Mon, 21 Nov 2005 13:54:39 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: infinite loop? with mmap, nfs, pwrite, O_DIRECT
To: Andrew Morton <akpm@osdl.org>
Cc: cel@citi.umich.edu, trond.myklebust@fys.uio.no,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051121123950.5afadab9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another data point:  In 2.6.8, the test works fine (just like on ext3).
Any suggestions as to where to start poking, or shall I just do a binary search?

-Kenny



	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
