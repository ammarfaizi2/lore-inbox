Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262496AbUKLK1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbUKLK1p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 05:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbUKLK1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 05:27:45 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:55123 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262496AbUKLK1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 05:27:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=aHaQh5Sxy10sVyocHK4uXY2mjsu7rEyZmHMKstQyuyR5MstujM3cS2bVw9e9heB1NVDDIQPdPKGp23kEoPHn/hj4RszV9dD8NAFl+XxypZtQCXTkUQcEHwafBAO+kXDNVaVodyZDD68MqCoD89nxBQcpc9Gofi/L0Q8z6nL09so=
Message-ID: <8ecd27430411120227411e865f@mail.gmail.com>
Date: Fri, 12 Nov 2004 05:27:42 -0500
From: Aristeu Sergio Rozanski Filho <aristeu.sergio@gmail.com>
Reply-To: Aristeu Sergio Rozanski Filho <aristeu.sergio@gmail.com>
To: Alexander Fieroch <fieroch@web.de>
Subject: Re: SNES gamepad doesn't work with kernel 2.6.x
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <cn0pvt$mcv$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <cn044e$nnk$1@sea.gmane.org>
	 <8ecd274304111108404f3ecd2c@mail.gmail.com>
	 <cn0pvt$mcv$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Yes, the modules parport and parport_pc are loaded.
> So what else is important and could cause this conflict?
could you send the output of 'dmesg' command? it may give a hint of
what's going on.
thanks,

-- 
Aristeu
