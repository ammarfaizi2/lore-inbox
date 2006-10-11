Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161466AbWJKVTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161466AbWJKVTh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161492AbWJKVTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:19:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41876 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161466AbWJKVSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:18:25 -0400
Message-ID: <452D5F49.70808@sandeen.net>
Date: Wed, 11 Oct 2006 16:16:57 -0500
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: "Phetteplace, Thad (GE Healthcare, consultant)" 
	<Thad.Phetteplace@ge.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com
Subject: Re: GRIO in Linux XFS?
References: <CAEAF2308EEED149B26C2C164DFB20F4DDE78B@ALPMLVEM06.e2k.ad.ge.com> <Pine.LNX.4.61.0610112129060.9822@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0610112129060.9822@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>> what is the status of GRIO support in the Linux port of XFS?
> 
> Called realtime volume.
> (http://en.wikipedia.org/wiki/XFS section 2.11)

Well, not really.  realtime was a part of the old griov1 setup on Irix,
but realtime != GRIO.

-Eric
