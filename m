Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129181AbRBURxY>; Wed, 21 Feb 2001 12:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129471AbRBURxF>; Wed, 21 Feb 2001 12:53:05 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:35142 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129181AbRBURxA>; Wed, 21 Feb 2001 12:53:00 -0500
Date: Wed, 21 Feb 2001 11:52:39 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Tigran Aivazian <tigran@veritas.com>
cc: Burton Windle <burton@fint.org>, linux-kernel@vger.kernel.org
Subject: Re: Detecting SMP
In-Reply-To: <Pine.LNX.4.21.0102211746330.2050-100000@penguin.homenet>
Message-ID: <Pine.LNX.3.96.1010221115214.13788T-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2001, Tigran Aivazian wrote:
> yes, just run the famous mptable program. If the machine is SMP then it
> will have a valid Intel MP 1.4 configuration tables so the program will
> show meaningful output.

Does that allow you to detect multiple processors... or just an SMP board?

	Jeff




