Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268372AbUIBOj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268372AbUIBOj1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 10:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268379AbUIBOj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 10:39:27 -0400
Received: from dh138.citi.umich.edu ([141.211.133.138]:54920 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S268372AbUIBOjZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 10:39:25 -0400
Subject: Re: [PATCH] Support supplementary information for request-key
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Steve Dickson <SteveD@redhat.com>,
       sfrench@samba.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Michael A Halcrow <mahalcro@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <9493.1094116801@redhat.com>
References: <1094057479.8528.28.camel@lade.trondhjem.org>
	 <1093973602.8410.62.camel@lade.trondhjem.org>
	 <1093906738.8729.141.camel@lade.trondhjem.org> <9710.1093510291@redhat.com>
	 <20040830152641.5621e55d.akpm@osdl.org> <7515.1093944336@redhat.com>
	 <2122.1094032562@redhat.com>   <9493.1094116801@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1094135952.9661.0.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 02 Sep 2004 10:39:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På to , 02/09/2004 klokka 05:20, skreiv David Howells:
> The attached patch adds support to the request key interface such that
> supplementary information can be passed to the /sbin/request-key program. This
> argument also controls whether or not that program will be invoked.

Yay!
