Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267513AbSLEVdp>; Thu, 5 Dec 2002 16:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267507AbSLEVcz>; Thu, 5 Dec 2002 16:32:55 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:25607 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267508AbSLEVbi>; Thu, 5 Dec 2002 16:31:38 -0500
Date: Thu, 5 Dec 2002 22:39:10 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ipv4: how to choose src ip?
Message-ID: <20021205213910.GB25006@louise.pinerecords.com>
References: <20021205190054.GE23877@louise.pinerecords.com> <20021205205817.GB21070@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021205205817.GB21070@alpha.home.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   ip route add default via 213.168.178.193 src 213.168.178.210

That's just what I needed, thanks Willy.

-- 
Tomas Szepe <szepe@pinerecords.com>
