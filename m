Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWFMXnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWFMXnU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 19:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWFMXnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 19:43:19 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:34728 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S932231AbWFMXnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 19:43:18 -0400
Message-ID: <448F4D6F.9070601@candelatech.com>
Date: Tue, 13 Jun 2006 16:42:39 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chase Venters <chase.venters@clientec.com>
CC: "Brian F. G. Bidulock" <bidulock@openss7.org>,
       Daniel Phillips <phillips@google.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Sridhar Samudrala <sri@us.ibm.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/2] in-kernel sockets API
References: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com> <20060613140716.6af45bec@localhost.localdomain> <20060613052215.B27858@openss7.org> <448F2A49.5020809@google.com> <20060613154031.A6276@openss7.org> <Pine.LNX.4.64.0606131655580.4856@turbotaz.ourhouse>
In-Reply-To: <Pine.LNX.4.64.0606131655580.4856@turbotaz.ourhouse>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase Venters wrote:

> At least some of us feel like stable module APIs should be explicitly 
> discouraged, because we don't want to offer comfort for code that 
> refuses to live in the tree (since getting said code into the tree is 
> often a goal).

Some of us write modules for specific features that are not wanted in
the mainline kernel, even though they are pure GPL.  Our life is hard
enough with out people setting out to deliberately make things more
difficult!

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

