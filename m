Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbVLFQpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbVLFQpL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 11:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbVLFQpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 11:45:11 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:48878 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932309AbVLFQpJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 11:45:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dAHBDsJMVxzYhd+1pnO9OQrMi0+cZWviVDRSsaa8EZv2MYrY+XbfaJE+I9HvV8C8sQc8dG8q2l7Cheklz5wL+jguqatp8+5R4tb26NTRWbxSszNkG6QS67yDAxdzmyRmrsfkXwj+jGT+uSG7hwVg+UYnizwBra7+x4rL7rJEu4c=
Message-ID: <d120d5000512060845l1d035f46ub8d9334b6936f9e7@mail.gmail.com>
Date: Tue, 6 Dec 2005 11:45:07 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
In-Reply-To: <20051206112127.GE10574@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051203135608.GJ31395@stusta.de>
	 <1133620264.2171.14.camel@localhost.localdomain>
	 <20051203193538.GM31395@stusta.de>
	 <1133639835.16836.24.camel@mindpipe>
	 <20051203225815.GH25722@merlin.emma.line.org>
	 <87y82z5kep.fsf@mid.deneb.enyo.de>
	 <1133816764.9356.72.camel@laptopd505.fenrus.org>
	 <87mzjf2gxs.fsf@mid.deneb.enyo.de>
	 <20051206112127.GE10574@merlin.emma.line.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/05, Matthias Andree <matthias.andree@gmx.de> wrote:
>
> QA has to happen at all levels if it is supposed to be affordable or
> scalable. The development process was scaled up, but QA wasn't.
>
> How about the Signed-off-by: lines? Those people who pass on the changes
> also pass on the bugs, and they are responsible for the code - not only
> license-wise, but also quality-wise. That's the latest point where
> regression tests MUST happen.

People who pass the changes can only test ones they have hardware for.
For the rest they can try to validate the code by reading patches but
have to rely on the submitter wrt to the patch actually working.

--
Dmitry
