Return-Path: <linux-kernel-owner+w=401wt.eu-S1751409AbWLLPLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWLLPLu (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 10:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWLLPLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 10:11:50 -0500
Received: from an-out-0708.google.com ([209.85.132.251]:2442 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbWLLPLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 10:11:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pTUSuqTgkfQYn2qm1EPpZ4LCUamziXnBG6z7BmPzMTm8mGRI5RMNhbPxeW+TZ+4tLjROMg2YQVEAw4sF/2Yi8bPr8ec4uF/GZ+wO3/GXVBlCh94NqJcBUTxpOGN4p+KroDwfX7WcAuHA0gBIqXPwmHsX5l2C4Vm6Q8xjhPDC7iY=
Message-ID: <aa5953d60612120711h375eecadpeb20d971853626cc@mail.gmail.com>
Date: Tue, 12 Dec 2006 20:41:47 +0530
From: "Jaswinder Singh" <jaswinderrajput@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: Support 2.4 modules features in 2.6
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1165932674.27217.608.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <aa5953d60612120606g8c59542seaa440b7b0404ff5@mail.gmail.com>
	 <1165932674.27217.608.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Tue, 2006-12-12 at 19:36 +0530, Jaswinder Singh wrote:
> > Hello,
> >
> > I want to support old 2.4 modules features in 2.6 kernel modules:-
> > 1. no kernel source tree is required to build modules.
>
> this is a 2.6 not a 2.4 feature btw
>

Really!! , Please let me know what is the procedure to build the
modules after deleting kernel linux-2.6*


> > 2. support modular plugins.
>
> ?

modular plugins means :-

module2 uses symbols of module1.
module3 uses symbols of module1 & module2.

Regards,

Jaswinder Singh.
