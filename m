Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbVLNOZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbVLNOZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 09:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVLNOZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 09:25:28 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:44379 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932535AbVLNOZ1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 09:25:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fWpW5CeySenZ8NOvMhURMDFqGhPw7BpG0Km/iR0KBVkfAYiWgybAB4WO6nCQfYW74YjD3BtH+Hy7qvplo1I8B5MjDK9IIoDYVZ6h1qmRnZMAf2p9xQLHzLExAlR6qjVjDgg2BjC6EK2uNIVSRzpYekj+7GlW1KeptOyd7Ih4M9o=
Message-ID: <81b0412b0512140625i7cc5779ar224de3d64c615fbc@mail.gmail.com>
Date: Wed, 14 Dec 2005 15:25:24 +0100
From: Alex Riesen <raa.lkml@gmail.com>
To: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: Help track down a freezing machine
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <dnp4t9$srl$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <dnp4t9$srl$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/05, Kalin KOZHUHAROV <kalin@thinrope.net> wrote:
> Now that I get a repetitive freeze, is there anything to debug the problem?
> I guess, the point when kernel is still responsive to keyboard, but I cannot login.

try to connect a serial console to it and press Alt+SysRq+t
