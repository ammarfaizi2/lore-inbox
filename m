Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263457AbVCECW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263457AbVCECW5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 21:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263640AbVCECSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 21:18:52 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:2870 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263533AbVCEB4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 20:56:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=RT+RLHNTYsVSdnGYJG+stYvGE60IwRuwoUU8RBG0oMYsAIGMMatj8p896XG59Tu8E/SNVxgbyzjPBPuULJ05/v3Hi1+wAhlpjct5GCqljWzrgCqoCGodtGXvAoGP5/K/Zxkj5RtIt2WLoeZSgXjCagsCIYVGxfbLPAEz9jmgWgA=
Message-ID: <711b967b0503041756748fe2fc@mail.gmail.com>
Date: Sat, 5 Mar 2005 10:56:46 +0900
From: Tejun Heo <htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.11-rc3 00/08] ide: taskfile cleanup
In-Reply-To: <20050305014758.4EDB4992@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050305014758.4EDB4992@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Oh, all the patches are against ide-dev-t + 9 recent patches +
ide_dma_intr fix.

--
tejun
