Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVA1Rid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVA1Rid (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 12:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVA1RfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 12:35:09 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:12489 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261491AbVA1ReO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 12:34:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=FQt8R4rBRK+2Iio3d/kZCjgDxVeyw47lSR6qjC7HNi2GIB6gvtfU9JpLuP+nrf1+/jYTBHG40R4rX62UuNV0jFeIDUO7lZ+4XFY/JeG8NmixN4jtETLpFzJZTYiUTqoAZBjvzp5X0dG8Kg/Upcu+tL1F3o3tAxFWgq+HN5/QKVk=
Message-ID: <d120d500050128093472935f8a@mail.gmail.com>
Date: Fri, 28 Jan 2005 12:34:13 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Olaf Hering <olh@suse.de>
Subject: Re: atkbd_init lockup with 2.6.11-rc1
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
In-Reply-To: <d120d500050128084345bb1abd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050128132202.GA27323@suse.de> <20050128135827.GA28784@suse.de>
	 <d120d50005012806435a17fe98@mail.gmail.com>
	 <20050128145511.GA29340@suse.de>
	 <d120d500050128072268a5c2f0@mail.gmail.com>
	 <20050128161746.GA1092@suse.de>
	 <d120d500050128084345bb1abd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005 11:43:44 -0500, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> This time  keyboard does not hang but NAKs everything instead...

Probably stupid question - does this box have AT keyboard? Or NAKs are
perfectly valid?

-- 
Dmitry
