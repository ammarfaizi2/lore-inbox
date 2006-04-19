Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWDSQBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWDSQBy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 12:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbWDSQBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 12:01:54 -0400
Received: from pproxy.gmail.com ([64.233.166.183]:13590 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750962AbWDSQBx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 12:01:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SWcdnTiGjzKNj8oHk4LSGITSZrnxtPhDAr10bWoGAmsA3WKRn7LK3lXrx84JFEGlf4xEqB6+1dIvDQQtRU8TDZNmR128p1EUrI/Wg0oAzLqs5ej/GUCUaAiQevYMMplvwE2MUjFI9hVlyYOehhMDhkIhAYrrPoixWG+D1stjvqg=
Message-ID: <35fb2e590604190901o784bfb8cj65d87d4ac354d785@mail.gmail.com>
Date: Wed, 19 Apr 2006 17:01:52 +0100
From: "Jon Masters" <jonathan@jonmasters.org>
To: "androi@inwind.it" <androi@inwind.it>
Subject: Re: Problems ejecting 4th-generation iPod with 2.6.15
Cc: greg <greg@kroah.com>, joshk <joshk@triplehelix.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <IXZ7WS$7C97ED4495AB8E41BB97FB4821D58030@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <IXZ7WS$7C97ED4495AB8E41BB97FB4821D58030@libero.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

On a related note, on my powerbooks here if I do an eject /dev/sda on
the iPod then I get a choice of failure - either the process blocks
and I pull the iPod, or the system locks hard.

Who else is getting weird behavior when they use "eject" and don't just yank it?

Jon.
