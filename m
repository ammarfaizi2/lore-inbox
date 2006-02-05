Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932595AbWBEDqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595AbWBEDqk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 22:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbWBEDqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 22:46:40 -0500
Received: from CPE-24-31-249-53.kc.res.rr.com ([24.31.249.53]:40167 "EHLO
	tsurukikun.utopios.org") by vger.kernel.org with ESMTP
	id S932595AbWBEDqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 22:46:39 -0500
From: Luke-Jr <luke@dashjr.org>
To: sclark46@earthlink.net
Subject: Re: WLAN drivers
Date: Sun, 5 Feb 2006 03:46:45 +0000
User-Agent: KMail/1.9
Cc: Lee Revell <rlrevell@joe-job.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Panagiotis Issaris <takis.issaris@uhasselt.be>,
       linux-kernel@vger.kernel.org, linux-netdev@vger.kernel.org
References: <1138969138.8434.26.camel@localhost.localdomain> <1138990013.15691.272.camel@mindpipe> <43E39E77.90403@earthlink.net>
In-Reply-To: <43E39E77.90403@earthlink.net>
Public-GPG-Key: 0xD53E9583
Public-GPG-Key-URI: http://dashjr.org/~luke-jr/myself/Luke-Jr.pgp
IM-Address: luke-jr@jabber.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602050346.48198.luke@dashjr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 February 2006 18:18, Stephen Clark wrote:
> The module includes a binary hal module that keeps the card from being
> abused - programmed out of FCC specs. Why is so different from a card that
> has to have firmware loaded on it that in essence does the same thing -
> prevents the driver writer from programming the card out of FCC specs.

How about let the user decide to comply with FCC (or not)? Maybe it's been 
exported? Maybe the user has a hack to make it receive an AM radio signal? 
Plenty of legal possibilities.
