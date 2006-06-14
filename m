Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbWFNAgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWFNAgU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 20:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWFNAgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 20:36:20 -0400
Received: from gw.openss7.com ([142.179.199.224]:64946 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S932377AbWFNAgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 20:36:18 -0400
Date: Tue, 13 Jun 2006 18:36:14 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Chase Venters <chase.venters@clientec.com>
Cc: Ben Greear <greearb@candelatech.com>,
       Daniel Phillips <phillips@google.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Sridhar Samudrala <sri@us.ibm.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/2] in-kernel sockets API
Message-ID: <20060613183614.C8460@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Chase Venters <chase.venters@clientec.com>,
	Ben Greear <greearb@candelatech.com>,
	Daniel Phillips <phillips@google.com>,
	Stephen Hemminger <shemminger@osdl.org>,
	Sridhar Samudrala <sri@us.ibm.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com> <200606131906.16683.chase.venters@clientec.com> <20060613181801.A8460@openss7.org> <200606131929.41985.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200606131929.41985.chase.venters@clientec.com>; from chase.venters@clientec.com on Tue, Jun 13, 2006 at 07:29:19PM -0500
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase,

On Tue, 13 Jun 2006, Chase Venters wrote:
> 
> But I did ask for examples...

Perhaps the license isn't a good example, but there are other RTP
stacks that are non-GPL compatible.  Also, if it includes SSL code
for SRTP, SSL license happens to be non-GPL compatible.
