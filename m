Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbVJZKkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbVJZKkw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 06:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbVJZKkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 06:40:52 -0400
Received: from [81.2.110.250] ([81.2.110.250]:65241 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932275AbVJZKkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 06:40:51 -0400
Subject: Re: EDAC (was: Re: 2.6.14-rc5-mm1)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: sander@humilis.net
Cc: Avuton Olrich <avuton@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051026074824.GA7121@favonius>
References: <20051024014838.0dd491bb.akpm@osdl.org>
	 <3aa654a40510251055r33b2b8a5kbd5c53471a243851@mail.gmail.com>
	 <1130265540.25191.55.camel@localhost.localdomain>
	 <20051026074824.GA7121@favonius>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 26 Oct 2005 12:09:49 +0100
Message-Id: <1130324989.25191.78.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-10-26 at 09:48 +0200, Sander wrote:
> Stupid question: should EDAC work on a Via Epia board? Because I see the
> "Detected Parity Error" messages too (and a lot of them), but figured
> that the option is just 'not an option' :-)

The PCI parity check should work on every correctly built PCI card and
bridge. 

> If it should work I'll be happy to send the error and lspci if that
> helps.

Please do. I'm trying to find the common items that cause spurious pci
errors

