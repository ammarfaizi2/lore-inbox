Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWJANt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWJANt0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 09:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWJANt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 09:49:26 -0400
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:33640 "HELO
	smtp102.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932192AbWJANtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 09:49:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=TkKUoph8d7KS9b4a2bGFAG1wl4PAsE5G/MLSRO2bmOCdLLNmzwZU5GS9IWO/H9Ad3d6qB0m4CwJzw4CpsCwJKbgKTN/QZVwd9HBqPqYootO1Iv0fv2IJihD3gxnAPRVYYBDG8jfDhWP4ZUqe2S6mZOK0bSFkBN2D4Ky+9XWj07o=  ;
From: David Brownell <david-b@pacbell.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 2.6.18-git] RTC class uses subsys_init
Date: Sun, 1 Oct 2006 06:49:20 -0700
User-Agent: KMail/1.7.1
Cc: Olaf Hering <olaf@aepfle.de>,
       Alessandro Zummo <alessandro.zummo@towertech.it>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200609282333.34224.david-b@pacbell.net> <20061001090717.GA14885@aepfle.de> <20061001022022.d7f86b39.akpm@osdl.org>
In-Reply-To: <20061001022022.d7f86b39.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610010649.21348.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 October 2006 2:20 am, Andrew Morton wrote:
> I'll fix it up.
> 
> (Wonders how it passed runtime testing..)

Thanks ... this is a "wrong patch version" got forwarded" issue, sorry.

- Dave
