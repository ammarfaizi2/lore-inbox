Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262698AbUKBXcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbUKBXcX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 18:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbUKBXcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 18:32:23 -0500
Received: from mproxy.gmail.com ([216.239.56.244]:63007 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262557AbUKBXcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 18:32:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=OKg1UnPGlLreOHn14ua1/yaMIR1dQw5NqkIQrhQo/lufAz2W08HbOL2MluEidLTQICv7gEh72Vlr+Dcu2Ro3xQMgRyFam6q+np7bLIq7dNntSnI2rl7CEcJkskKIRNc1+GF3mMjx18UPR0zN8BZQ/KWS3OKHDX9tXCwxeJw5gxY=
Message-ID: <21d7e9970411021532498d12df@mail.gmail.com>
Date: Wed, 3 Nov 2004 10:32:02 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: 2.6.10-rc1-bk12 still hangs when starting X on a radeon 9200 SE card
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041102231638.GA12983@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041102231638.GA12983@hh.idb.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 2.6.8.1 does not have this problem.  This is an
> opteron machine, running a x86 kernel.

Hmm I can't see what could be on the radeon, what is your
.config/dmesg look like

I'm thinking the two-card might be broken, can you not load the mga card driver?

Dave.
