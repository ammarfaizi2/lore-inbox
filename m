Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWCLLdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWCLLdp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 06:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWCLLdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 06:33:45 -0500
Received: from main.gmane.org ([80.91.229.2]:62914 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751423AbWCLLdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 06:33:45 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: [PATCH] [PNP] 'modalias' sysfs export
Date: Sun, 12 Mar 2006 12:33:22 +0100
Message-ID: <pan.2006.03.12.11.33.22.447180@free.fr>
References: <20060227214018.3937.14572.stgit@poseidon.drzeus.cx> <20060301194532.GB25907@vrfy.org> <4406AF27.9040700@drzeus.cx> <20060302165816.GA13127@vrfy.org> <44082E14.5010201@drzeus.cx> <4412F53B.5010309@drzeus.cx> <20060311173847.23838981.akpm@osdl.org> <4414033F.2000205@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le Sun, 12 Mar 2006 12:17:19 +0100, Pierre Ossman a écrit :
> The reason I'm pushing this issue is that Red Hat decided to drop all
> magical scripts that figured out what modules to load and instead only
> use the modalias attribute. They consider the right way to go is to get
> the PNP layer to export modalias, so that's what I'm trying to do.
> 
> Bugzilla entry for those interested:
> 
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=146405
> 
IIRC debian maintainers want also to use only modalias stuff.
see
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=337004
and http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=334238

Matthieu

