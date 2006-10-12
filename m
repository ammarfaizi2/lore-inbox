Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWJLLaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWJLLaQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 07:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWJLLaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 07:30:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:52049 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751245AbWJLLaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 07:30:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=pFMVf71MF1tVuiIuJJyQXqFXmYe9GWJAdS7D/VbX7xGIrAPmtyLE9Myc0Wg7ezWRuqWHgd4BMKbP6lTIQ4I4Hdjs6+eJz2Aolb2a/hg1BOZGHsWiBf5ugoKrvz4AkzI+mhMGQPl/kRe+rNzP8BL8vzUvBlxq+IvquJSPjA7CFkc=
Message-ID: <84144f020610120430r382bc860t5092ddb2a343d2d9@mail.gmail.com>
Date: Thu, 12 Oct 2006 14:30:09 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: jplatte@naasa.net
Subject: Re: Userspace process may be able to DoS kernel
Cc: "=?ISO-8859-1?Q?G=FCnther_Starnberger?=" <gst@sysfrog.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200610120802.59077.lists@naasa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <474c7c2f0610110954y46b68a14q17b88a5e28ffe8d9@mail.gmail.com>
	 <200610120802.59077.lists@naasa.net>
X-Google-Sender-Auth: 72839664f39dbd9a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 10/12/06, Joerg Platte <lists@naasa.net> wrote:
> Using 2.6.18 does not solve the problem. I can see exactly the same behavior
> with a vanilla and not tainted 2.6.18 kernel.

Do you see this with 2.6.16 also or is it new to 2.6.17?

                                           Pekka
