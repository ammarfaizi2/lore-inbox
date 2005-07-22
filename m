Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVGVQZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVGVQZo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 12:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVGVQZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 12:25:44 -0400
Received: from quechua.inka.de ([193.197.184.2]:43451 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261312AbVGVQZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 12:25:42 -0400
Date: Fri, 22 Jul 2005 18:25:39 +0200
From: Bernd Eckenfels <be-mail2005@lina.inka.de>
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: a 15 GB file on tmpfs
Message-ID: <20050722162539.GA25577@lina.inka.de>
References: <E1Dvusr-00048r-00@calista.eckenfels.6bone.ka-ip.net> <42E0D1C2.8080703@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42E0D1C2.8080703@stesmi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2005 at 01:00:18PM +0200, Stefan Smietanowski wrote:
> > You cant have 16GB of Memory with 32bit CPUs.
> PAE
> CONFIG_HIGMEM64G
> Supports a 36bit address space, which Xeons do support.

Yes right, I was just not aware recent hardware (still) supports that. I
mean even mit 2MB modules most of them are specified only to 8GB. I would
consider buying such a system quite foolish. All of the HP servers with 12GB
and more seem to support EM64T. Do you know vendors who ship non-EM64T
servers with more than 16GB?

Gruss
Bernd
-- 
  (OO)     -- Bernd_Eckenfels@Mörscher_Strasse_8.76185Karlsruhe.de --
 ( .. )    ecki@{inka.de,linux.de,debian.org}  http://www.eckes.org/
  o--o   1024D/E383CD7E  eckes@IRCNet  v:+497211603874  f:+49721151516129
(O____O)  When cryptography is outlawed, bayl bhgynjf jvyy unir cevinpl!
