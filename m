Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268295AbUICU1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268295AbUICU1W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 16:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269754AbUICU1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 16:27:22 -0400
Received: from serwer.tvgawex.pl ([212.122.214.2]:54335 "HELO
	mother.localdomain") by vger.kernel.org with SMTP id S268295AbUICU1N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 16:27:13 -0400
Date: Fri, 3 Sep 2004 22:27:17 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: md RAID over SATA performance
Message-ID: <20040903202717.GD4075@irc.pl>
Mail-Followup-To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <1094169937l.17931l.0l@werewolf.able.es> <41389CDA.5060609@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41389CDA.5060609@rtr.ca>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 12:33:30PM -0400, Mark Lord wrote:
> Unless O_DIRECT is used (hdparm --direct), in which case they

 In which version of hdparm? I'm using 5.6 (I believe it's latest) which
doesn't know --direct switch.

-- 
Tomasz Torcz                 "God, root, what's the difference?" 
zdzichu@irc.-nie.spam-.pl         "God is more forgiving."   

