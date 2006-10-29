Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965194AbWJ2NHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965194AbWJ2NHS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 08:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965196AbWJ2NHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 08:07:18 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:23037 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965194AbWJ2NHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 08:07:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=J3mH20bU05YQqQvlkJat5+etbePl6dw/z/t/Ceiub5aaUyCssF948AlJbDZidu4S66MddbdmNS4G8W79SVXrC+gx7hjjKgV5vcSvOr3/mifsnPRPZsXxjOcKZM35y7nVOjO7+rbMUFGOkile9dtU1AJpvU732max9tDFdoU5msQ=
Date: Sun, 29 Oct 2006 15:05:34 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: why test for "__GNUC__"?
Message-ID: <20061029120534.GA4906@martell.zuzino.mipt.ru>
References: <Pine.LNX.4.64.0610290610020.6502@localhost.localdomain> <Pine.LNX.4.61.0610291244310.15986@yvahk01.tjqt.qr> <Pine.LNX.4.64.0610290742310.7457@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610290742310.7457@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2006 at 07:44:18AM -0500, Robert P. J. Day wrote:
> p.s.  is there, in fact, any part of the kernel source tree that has a
> preprocessor directive to identify the use of ICC?  just curious.

Please, do

	ls include/linux/compiler-*

