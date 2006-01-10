Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751764AbWAJAMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbWAJAMP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 19:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbWAJAMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 19:12:15 -0500
Received: from khc.piap.pl ([195.187.100.11]:22797 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751297AbWAJAMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 19:12:15 -0500
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: "Alexander E. Patrakov" <patrakov@gmail.com>,
       Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] It's UTF-8
References: <20060108203851.GA5864@mipter.zuzino.mipt.ru>
	<43C21E9D.3070106@gmail.com> <m3ek3hhbs0.fsf@defiant.localdomain>
	<1136832266.10433.1.camel@bip.parateam.prv>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 10 Jan 2006 01:12:05 +0100
In-Reply-To: <1136832266.10433.1.camel@bip.parateam.prv> (Xavier Bestel's message of "Mon, 09 Jan 2006 19:44:26 +0100")
Message-ID: <m31wzhgcve.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel <xavier.bestel@free.fr> writes:

>> And UTF-8 locale seems to be the only really sane today. I'd kill the
>> whole warning.
>
> .. on unix. But FAT is a sort of lingua franca of filesystems, and is
> the only one understandable by every (embedded) OS. So you'd better stay
> compatible with everyone else.

You stay compatible. And you can even read files with national
characters in names.
-- 
Krzysztof Halasa
