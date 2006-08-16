Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWHPTK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWHPTK6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 15:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbWHPTK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 15:10:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:9248 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750909AbWHPTK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 15:10:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nh+6kYPfXFqRkL249OfZtmkgB7xDiFrmS5g9Vgyngk24pQ6MSBs2Q23QxBmf/xPUrtFLjH9ej2y0BANREuTuZFaMceBIO6jlIvHCkJVP2TXhopbmq+VkYCI6Rqz9YEUDf7sgqsc22/AVhPyRsZQcGzx3G9G4MMWIzEkD9PTHAk4=
Message-ID: <7c3341450608161210ua4d0d4esc54f98c3ada69f3d@mail.gmail.com>
Date: Wed, 16 Aug 2006 20:10:56 +0100
From: "Nick Warne" <nick.warne@gmail.com>
Reply-To: nick@linicks.net
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: PATCH: Fix crash case
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0608161938320.20450@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1155746131.24077.363.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0608161938320.20450@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for being a noob here - I read LKML to try to learn.

What is meant by 'If we are going to BUG()...  cover the case
of the BUG being compiled out'.

What would make BUG(); not being compiled?

Nick
