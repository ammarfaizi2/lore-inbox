Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWEWINn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWEWINn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 04:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWEWINn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 04:13:43 -0400
Received: from stingr.net ([212.193.32.15]:30651 "EHLO stingr.net")
	by vger.kernel.org with ESMTP id S932105AbWEWINm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 04:13:42 -0400
Date: Tue, 23 May 2006 12:13:08 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: alan@lxorguk.ukuu.org.uk, rick.jones2@hp.com, vladislav.yasevich@hp.com,
       i@stingr.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Was change to ip_push_pending_frames intended to break udp (more specifically, WCCP?)
Message-ID: <20060523081308.GB8196@stingr.net>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	alan@lxorguk.ukuu.org.uk, rick.jones2@hp.com,
	vladislav.yasevich@hp.com, i@stingr.net,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <1148322152.15322.299.camel@galen.zko.hp.com> <4472078D.8010706@hp.com> <1148332293.17376.114.camel@localhost.localdomain> <20060522.161951.92584947.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060522.161951.92584947.davem@davemloft.net>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to David S. Miller:
> That's my position too and I'm pretty much going to ignore any
> request to change this behavior.

Accorind to this article, some people count this as security issue:
http://www.securityfocus.com/archive/1/427622

Well ... someone with Cisco support contract can open a TAC case on
this ?

-- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head
