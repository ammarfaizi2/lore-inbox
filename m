Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWGMIa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWGMIa5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 04:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWGMIa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 04:30:57 -0400
Received: from gw.goop.org ([64.81.55.164]:45740 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932443AbWGMIa4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 04:30:56 -0400
Message-ID: <44B604C8.90607@goop.org>
Date: Thu, 13 Jul 2006 01:31:04 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: George Nychis <gnychis@cmu.edu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: suspend/hibernate to work on thinkpad x60s?
References: <44B5CE77.9010103@cmu.edu>
In-Reply-To: <44B5CE77.9010103@cmu.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Nychis wrote:
> I was wondering if anyone has gotten suspend or hibernate to work on a
> Thinkpad x60s?  I have googled around for support in the kernel and
> haven't been able to find anyone fully successful with it.
>   
I have suspend/resume working fine on an X60.  Needs some patches to 
make it work though.  What problems are you seeing?

    J
