Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbVC2GWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbVC2GWN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 01:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbVC2GWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 01:22:13 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:27884 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262450AbVC2GWF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 01:22:05 -0500
References: <ie2p3m.2u2ccu.3z4p19m1j53m9pob6l5ceeebq.refire@cs.helsinki.fi>
            <20050328200252.GN28536@shell0.pdx.osdl.net>
            <20050328223048.GA2741@pclin040.win.tue.nl>
In-Reply-To: <20050328223048.GA2741@pclin040.win.tue.nl>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: isofs: unobfuscate rock.c
Date: Tue, 29 Mar 2005 09:22:04 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.4248F40C.00006DA4@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andries, 

Andries Brouwer writes:
> Good! When Linus asked I audited rock.c and also did rather similar polishing -
> it happens automatically if one looks at this code. But it seems everybody is
> doing this right now, so I must wait a few weeks and see what got into Linus'
> tree. Linus plugged many but not all holes. (Maybe you did more?)

I didn't fix anything. I tried to be very careful about preserving the 
current logic while making it more readable so I could find bugs :-). 

              Pekka 

