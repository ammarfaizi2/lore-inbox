Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWAZUFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWAZUFL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 15:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWAZUFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 15:05:11 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:38436 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751392AbWAZUFK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 15:05:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XoD4XjKVYRKBebUUX0orfB2ir8DgqZglN0m/EPcvu92Q6WNvPiXxwMCDdFnnnxDu5KbOOaxc24nnPG1Uv6jKip7d/s8YImmWMU/Psgiw4NhLGE/zlm4/+XfNH6cfpIs/KarQXdJSAKplIzT4qbXHKwvkyqLo2Ur/zgAG3KKZaY4=
Message-ID: <29495f1d0601261205u62aec435xfe6f94dc998934dc@mail.gmail.com>
Date: Thu, 26 Jan 2006 12:05:08 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: horst@schirmeier.com
Subject: Re: Badness in vsnprintf
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060126195038.GB22994@quickstop.soohrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060126195038.GB22994@quickstop.soohrt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/06, Horst Schirmeier <horst@schirmeier.com> wrote:
> Hi,
>
> since I'm testing the 2.6.16 release candidate, I'm encountering the
> following problem which manifests by a reported "Badness in vsnprintf"
> in dmesg. The system is still usable after this event.

I think this is also discussed here
http://lkml.org/lkml/2006/1/22/163. And there is a patch therein to
fix it (http://lkml.org/lkml/2006/1/24/237).

Thanks,
Nish
