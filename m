Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271812AbTHRNkw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 09:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271814AbTHRNkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 09:40:43 -0400
Received: from dsl-213-023-213-112.arcor-ip.net ([213.23.213.112]:42887 "EHLO
	server1.intern.kubla.de") by vger.kernel.org with ESMTP
	id S271812AbTHRNka convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 09:40:30 -0400
From: Dominik Kubla <dominik.kubla@sciobyte.com>
To: Stephan von Krawczynski <skraw@ithnet.com>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Date: Mon, 18 Aug 2003 15:40:23 +0200
User-Agent: KMail/1.5.3
Cc: willy@w.ods.org, alan@lxorguk.ukuu.org.uk, carlosev@newipnet.com,
       lamont@scriptkiddie.org, davidsen@tmr.com, bloemsaa@xs4all.nl,
       marcelo@conectiva.com.br, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       layes@loran.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20030728213933.F81299@coredump.scriptkiddie.org> <20030818044419.0bc24d14.davem@redhat.com> <20030818143401.1352d158.skraw@ithnet.com>
In-Reply-To: <20030818143401.1352d158.skraw@ithnet.com>
Organization: ScioByte Information Technologies
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308181540.23709.dominik.kubla@sciobyte.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 18. August 2003 14:34 schrieb Stephan von Krawczynski:

> David, this is the wrong way round. Others'/my question was not about the
> implementation and technical considerations leading to it (bottom up), but
> pure and simple (and top down): what is the _positive_ outcome of this
> implementation compared to others? We are always talking of setups that
> seem to be more complicated because of the current situation. So one would
> expect that there are advantages that make up the discussed disadvantages.
> And since I obviously don't have the knowledge to see them, I'd like to
> learn and therefore ask: what are the advantages on the _users_ side?

Very simple: no need for any IPMP crap on Linux. It just works.  And that puts 
"answered" on all questions that were ever raised regarding that issue.

Regards,
  Dominik
-- 
ScioByte GmbH                     | ScioByte Information Technologies AG
Fritz-Erler-Strasse 6             | Innere Güterstrasse 4
55129 Mainz (Germany)             | 6304 Zug (Switzerland)
Phone: +49 700 724 629 83         | Phone: +41 41 710 30 18
Fax:   +49 700 724 629 84         |

GnuPG: 1024D/717F16BB A384 F5F1 F566 5716 5485  27EF 3B00 C007 717F 16BB

