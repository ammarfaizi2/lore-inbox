Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262289AbUKKQlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbUKKQlQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 11:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbUKKQlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 11:41:16 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:55757 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262289AbUKKQkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 11:40:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=c6yX32ZXFOi9/NyZZBTzd7/7wdm3JMdS1g4/Ewzs2fM3rhkNCJb12ljFZ928wjT1BUsyRl9sRiK1dK9TQJSfq+fD5G5c7T88teO2BgMmUGQMwjM58l5SIj10kC/vtriN0dXj66K0lyD2uBUBnXOc9BWYhyhiLQ16e8pA2MZ6IA8=
Message-ID: <8ecd274304111108404f3ecd2c@mail.gmail.com>
Date: Thu, 11 Nov 2004 11:40:06 -0500
From: Aristeu Sergio Rozanski Filho <aristeu.sergio@gmail.com>
Reply-To: Aristeu Sergio Rozanski Filho <aristeu.sergio@gmail.com>
To: Alexander Fieroch <fieroch@web.de>
Subject: Re: SNES gamepad doesn't work with kernel 2.6.x
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <cn044e$nnk$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <cn044e$nnk$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
> With kernel 2.4.x there are no problems - so is it a bug?
it works for me without problems. are you sure that you loaded
parport_pc as well?

--
Aristeu
