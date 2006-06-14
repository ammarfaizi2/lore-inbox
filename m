Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWFNSDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWFNSDG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 14:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWFNSDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 14:03:06 -0400
Received: from gw.openss7.com ([142.179.199.224]:52157 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S1751194AbWFNSDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 14:03:04 -0400
Date: Wed, 14 Jun 2006 12:03:02 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Daniel Phillips <phillips@google.com>
Cc: Harald Welte <laforge@gnumonks.org>,
       Stephen Hemminger <shemminger@osdl.org>,
       Sridhar Samudrala <sri@us.ibm.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/2] in-kernel sockets API
Message-ID: <20060614120302.A24700@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Daniel Phillips <phillips@google.com>,
	Harald Welte <laforge@gnumonks.org>,
	Stephen Hemminger <shemminger@osdl.org>,
	Sridhar Samudrala <sri@us.ibm.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com> <20060613140716.6af45bec@localhost.localdomain> <20060613052215.B27858@openss7.org> <448F2A49.5020809@google.com> <20060614133022.GU11863@sunbeam.de.gnumonks.org> <44904C08.6020307@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <44904C08.6020307@google.com>; from phillips@google.com on Wed, Jun 14, 2006 at 10:48:56AM -0700
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

On Wed, 14 Jun 2006, Daniel Phillips wrote:
> 
> Speaking as a former member of a "grey market" binary module vendor that
> came in from the cold I can assure you that the distinction between EXPORT
> and EXPORT_GPL _is_ meaningful.  That tainted flag makes it extremely
> difficult to do deals with mainstream Linux companies and there is always
> the fear that it will turn into a legal problem.  The latter bit tends to
> make venture capitalists nervous.
> 

EXPORT_SYMBOL_GPL and the Tainted flag have nothing to do with each other.

