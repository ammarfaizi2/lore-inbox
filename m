Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266063AbUF2VPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266063AbUF2VPO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 17:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266067AbUF2VPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 17:15:14 -0400
Received: from quechua.inka.de ([193.197.184.2]:42429 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S266063AbUF2VPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 17:15:11 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: possible arp table corruption [2.4.18]
Organization: Deban GNU/Linux Homesite
In-Reply-To: <20040629200558.GH25252@carsten-otto.halifax.rwth-aachen.de>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BfPwb-0006gl-00@calista.eckenfels.6bone.ka-ip.net>
Date: Tue, 29 Jun 2004 23:15:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040629200558.GH25252@carsten-otto.halifax.rwth-aachen.de> you wrote:
> I don't know if the kernel or "arp" or something else is broken

the /proc interface is most likely broken in some way :)

>   - if I am doing something wrong

you can try "arpd -p", "cat /proc/net/arp"  and 2ip neigh show"  
in addition to your arp script.

Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
