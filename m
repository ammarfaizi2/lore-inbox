Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbVLFFii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbVLFFii (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 00:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbVLFFii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 00:38:38 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:36868 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964798AbVLFFih convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 00:38:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KY+HUDCkCWKXVlFouxUzbTq33uGg7FyyNVG3ZQvec/Su65MLLGfRI01QLO9NEywf9+HDL4mS14w9YNvvBlW1RokQeRwQxN0sTGK0F/g6DC7TUMk+vNw89jKzLSn1CirQRmd1d1XUMiwIT+pKLlSNOePWhwvrOE1dv4TCQirzReg=
Message-ID: <a762e240512052138i3243761fl25f750f351f0b7f0@mail.gmail.com>
Date: Mon, 5 Dec 2005 21:38:36 -0800
From: Keith Mannthey <kmannth@gmail.com>
To: Rob Landley <rob@landley.net>
Subject: Re: Kernel BUG at page_alloc.c:117!
Cc: zine el abidine Hamid <zine46@yahoo.fr>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200512052306.18420.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051205150530.91163.qmail@web30607.mail.mud.yahoo.com>
	 <200512052306.18420.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You might want to file a bug with the distro you are running. The
kernel numbering seems to be RedHat?  Perhaps they have seen and fixed
the problem already upsteam in their tree somewhere.
