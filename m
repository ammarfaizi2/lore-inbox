Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264894AbUFLSW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264894AbUFLSW5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 14:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264896AbUFLSW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 14:22:57 -0400
Received: from quechua.inka.de ([193.197.184.2]:30876 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S264894AbUFLSW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 14:22:56 -0400
Date: Sat, 12 Jun 2004 20:22:54 +0200
From: Bernd Eckenfels <be-mail2004@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O_NOATIME support
Message-ID: <20040612182254.GB31162@lina.inka.de>
References: <20040612011129.GD1967@flower.home.cesarb.net> <E1BZBbt-0007jL-00@calista.eckenfels.6bone.ka-ip.net> <20040612180918.GA21857@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040612180918.GA21857@taniwha.stupidest.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2004 at 11:09:18AM -0700, Chris Wedgwood wrote:
> They are ABI specific and will never change.

Yes, Thats even more an argument for introducing a value which is  the  same on
all architectures, since it can never be changed again.

Greetings
Bernd
-- 
  (OO)      -- Bernd_Eckenfels@Mörscher_Strasse_8.76185Karlsruhe.de --
 ( .. )      ecki@{inka.de,linux.de,debian.org}  http://www.eckes.org/
  o--o     1024D/E383CD7E  eckes@IRCNet  v:+497211603874  f:+497211606754
(O____O)  When cryptography is outlawed, bayl bhgynjf jvyy unir cevinpl!
