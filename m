Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261404AbREVMIj>; Tue, 22 May 2001 08:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261411AbREVMI3>; Tue, 22 May 2001 08:08:29 -0400
Received: from barnowl.demon.co.uk ([158.152.23.247]:1029 "EHLO
	barnowl.demon.co.uk") by vger.kernel.org with ESMTP
	id <S261404AbREVMIP>; Tue, 22 May 2001 08:08:15 -0400
Mail-Copies-To: nobody
To: linux-kernel@vger.kernel.org
Subject: Re: ECN is on!
In-Reply-To: <20010522131031.C5947@mea-ext.zmailer.org>
From: Graham Murray <graham@barnowl.demon.co.uk>
Date: 22 May 2001 12:07:34 +0000
In-Reply-To: <20010522131031.C5947@mea-ext.zmailer.org> (Matti Aarnio's message of "Tue, 22 May 2001 13:10:31 +0300")
Message-ID: <m28zjpsi2h.fsf@barnowl.demon.co.uk>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio <matti.aarnio@zmailer.org> writes:

> ... and immediately I have been able to verify a bunch of
> domains/servers which won't get thru when incoming connection
> has ECN.

As a matter of interest, are you also noting how many actually
negotiate ECN rather than simply responding with a "plain" SYN ACK? 

