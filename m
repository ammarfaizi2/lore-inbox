Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267974AbTBMGTE>; Thu, 13 Feb 2003 01:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267975AbTBMGTE>; Thu, 13 Feb 2003 01:19:04 -0500
Received: from rth.ninka.net ([216.101.162.244]:24706 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S267974AbTBMGTE>;
	Thu, 13 Feb 2003 01:19:04 -0500
Subject: Re: Routing problem with udp, and a multihomed host in 2.4.20
From: "David S. Miller" <davem@redhat.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15946.54853.37531.810342@notabene.cse.unsw.edu.au>
References: <15946.54853.37531.810342@notabene.cse.unsw.edu.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Feb 2003 23:11:18 -0800
Message-Id: <1045120278.5115.0.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-12 at 15:18, Neil Brown wrote:
> Is this a bug, or is there some configuration I can change?

Specify the correct 'src' parameter in your 'ip' route
command invocations.

