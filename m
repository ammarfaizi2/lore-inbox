Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbWCMUjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWCMUjl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 15:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbWCMUjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 15:39:41 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:17671 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750960AbWCMUjk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 15:39:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j9J57msMdYz8AI71pS1NG40B9UDc3PhkyyUbUEqEuSn5ND5zLbhT9ijuYUIrMi8S4KS+gB8cc/4GDqiCEOVnC+rlktuA4Y72srILifgwre50HVQKmzCsIQYw08JJ1kpf0aPJwn89ldg4yswSrevEH7kRC0kL2xMzdWhC2bl8VSk=
Message-ID: <3b0ffc1f0603131239o6c6b07cft23407f574afb0d40@mail.gmail.com>
Date: Mon, 13 Mar 2006 15:39:40 -0500
From: "Kevin Radloff" <radsaq@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: New libata PATA patch for 2.6.16-rc1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1142262431.25773.25.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1142262431.25773.25.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Available from
>
> http://zeniv.linux.org.uk/~alan/IDE/

I still see the same oops in make_class_name with pata_pcmcia upon
insertion of a CF memory card as I previously reported to you with
2.6.16-rc5-ide1.

--
Kevin 'radsaq' Radloff
radsaq@gmail.com
http://thesaq.com/
