Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264274AbTEZFnH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 01:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbTEZFnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 01:43:06 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:2832 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264274AbTEZFnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 01:43:05 -0400
Date: Mon, 26 May 2003 06:56:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Maciej Soltysiak <solt@dns.toxicfilms.tv>, davem@caip.rutgers.edu,
       Eric.Schenk@dna.lth.se, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make icmp.c be more verbose on broadcast icmp errors
Message-ID: <20030526065602.A19100@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"David S. Miller" <davem@redhat.com>,
	Maciej Soltysiak <solt@dns.toxicfilms.tv>, davem@caip.rutgers.edu,
	Eric.Schenk@dna.lth.se, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.51.0305231222450.8169@dns.toxicfilms.tv> <1053922444.14018.7.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1053922444.14018.7.camel@rth.ninka.net>; from davem@redhat.com on Sun, May 25, 2003 at 09:14:04PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 25, 2003 at 09:14:04PM -0700, David S. Miller wrote:
> None of the people on the CC: list maintain the networking
> code, I have no idea where you've obtained that outdated
> contact information.  Eric hasn't done networking work for
> at least 4 or 5 years, and it's been a similarly long time
> since I've ever used that old rutgers.edu address for myself.

net/README:

---- snip ----
ipv4                    davem@caip.rutgers.edu,Eric.Schenk@dna.lth.se
ipv6                    davem@caip.rutgers.edu,Eric.Schenk@dna.lth.se
---- snip ----

probably this file should be removed completly - it's horribly outdated
and we have MAINTAINERS for that purpose..

