Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751494AbWEUHXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWEUHXj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 03:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWEUHXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 03:23:39 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:16337 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751494AbWEUHXi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 03:23:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=SSktstiYLBOPfwkWEjgqefJoK8bJyNrN495n/LDvujTS0H8pj0LfXO4P1g9h7JEN28liDH3Q1fSiYB9ho88Gs1QaK9q4Y8AeitNyuQIyVKhnM1Y86LrjM9ff+47Hb958lHXJCKIZ/zsxLTC9sy3CCluyo3JF6mouANadK8WOSFo=
Message-ID: <84144f020605210023r7333f6a9nb3dfe1d7a67f87fe@mail.gmail.com>
Date: Sun, 21 May 2006 10:23:37 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "David Vrabel" <dvrabel@cantab.net>
Subject: Re: [PATCH 2/2] ipg: redundancy with mii.h
Cc: "Francois Romieu" <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, jesse@icplus.com.tw, david@pleyades.net
In-Reply-To: <446F840E.3020808@cantab.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <44554ADE.8030200@cantab.net>
	 <20060501231206.GD7419@electric-eye.fr.zoreil.com>
	 <Pine.LNX.4.58.0605020945010.4066@sbz-30.cs.Helsinki.FI>
	 <20060502214520.GC26357@electric-eye.fr.zoreil.com>
	 <20060502215559.GA1119@electric-eye.fr.zoreil.com>
	 <Pine.LNX.4.58.0605030913210.6032@sbz-30.cs.Helsinki.FI>
	 <20060503233558.GA27232@electric-eye.fr.zoreil.com>
	 <1146750276.11422.0.camel@localhost>
	 <20060504235549.GA9128@electric-eye.fr.zoreil.com>
	 <446F840E.3020808@cantab.net>
X-Google-Sender-Auth: 5d457adc4e57da88
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 5/21/06, David Vrabel <dvrabel@cantab.net> wrote:
> Did anyone manage to get a response from IC Plus regarding the required
> Signed-off-by line?

The current IP1000A driver maintainer at IC Plus is
jesse@icplus.com.tw.  I have no received confirmation if he can sign
off or not yet.

                                         Pekka
