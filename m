Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVGTWhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVGTWhN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 18:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVGTWhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 18:37:13 -0400
Received: from khc.piap.pl ([195.187.100.11]:28933 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S261520AbVGTWhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 18:37:12 -0400
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org
Subject: Re: kernel guide to space
References: <20050711145616.GA22936@mellanox.co.il>
	<9a87484905072005596f2c2b51@mail.gmail.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 21 Jul 2005 00:37:09 +0200
In-Reply-To: <9a87484905072005596f2c2b51@mail.gmail.com> (Jesper Juhl's
 message of "Wed, 20 Jul 2005 14:59:51 +0200")
Message-ID: <m3pstd2jfu.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> writes:

> I don't think that's a hard rule, there's plenty of code that does 
> "sizeof(type)"  and not  "sizeof (type)", and whitespace cleanup
> patches I've done that change "sizeof (type)" into "sizeof(type)" have
> generally been accepted.

Sure, the common rule is that function names and alike (including "sizeof")
are not followed by a space. Statements such as "if", "while" etc. - are.
-- 
Krzysztof Halasa
