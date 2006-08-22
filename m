Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWHVVOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWHVVOq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 17:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWHVVOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 17:14:46 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:57666 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751273AbWHVVOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 17:14:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dxng0Ss0Jv8tH8HGxfOugBjWIzzXxdYWaAN7l916O6cPrXpEavLQ/Efulh3MEPDcwmH2pkVUR/tAcbddovz5bko5xviW/TwUj5sQZs1iTeC8oacbHpI1yHmW8u2mA/CPTE7z10cRej3vr0lOxjeM09mJPZBRNcfLM/Fog3n/Y8o=
Message-ID: <36e6b2150608221414g418304c0u42c769d5a283863c@mail.gmail.com>
Date: Wed, 23 Aug 2006 01:14:43 +0400
From: "Paul Drynoff" <pauldrynoff@gmail.com>
To: "Frederik Deweerdt" <deweerdt@free.fr>
Subject: Re: [BUG] Can not boot linux-2.6.18-rc4-mm2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060822211435.GA724@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060822125118.12ba1ed4.pauldrynoff@gmail.com>
	 <20060822205053.37472ba7.pauldrynoff@gmail.com>
	 <20060822211435.GA724@slug>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/06, Frederik Deweerdt <deweerdt@free.fr> wrote:
> Are you able to hook a gdb on qemu ?
> Frederik

Yes, but it not helps to find reason of problem.
