Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130388AbRBQTvl>; Sat, 17 Feb 2001 14:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131028AbRBQTva>; Sat, 17 Feb 2001 14:51:30 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:16625 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130388AbRBQTvS>; Sat, 17 Feb 2001 14:51:18 -0500
Message-ID: <3A8ED567.476C1C4B@sympatico.ca>
Date: Sat, 17 Feb 2001 14:47:51 -0500
From: Jeremy Jackson <jeremy.jackson@sympatico.ca>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: jbinpg@home.com
CC: stefan@hanse.com, linux-kernel@vger.kernel.org
Subject: Re: re. too long mac address for --mac-source netfilter option
In-Reply-To: <20010217194308.GKTJ585.mail2.rdc2.bc.home.com@nonesuch.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jbinpg@home.com wrote:

>All hits on my firewall from cable modem servers other than my own provider also have the 14 group "MAC" address so it l>ooks like this may be a feature of these units.

Some cable providers use Ethernet bridging instead of full ip routing.  perhaps this is what you are seeing.
Maybe TCPdump will label packets which are for "spanning tree" or similar?

