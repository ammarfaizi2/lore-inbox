Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266263AbRHAJq0>; Wed, 1 Aug 2001 05:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266251AbRHAJqQ>; Wed, 1 Aug 2001 05:46:16 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:3915 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S266293AbRHAJp6>;
	Wed, 1 Aug 2001 05:45:58 -0400
Date: Wed, 1 Aug 2001 10:47:19 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: booting SMP P6 kernel on P4 hangs.
In-Reply-To: <3B67CE6A.A670093E@redhat.com>
Message-ID: <Pine.LNX.4.21.0108011045030.785-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2001, Arjan van de Ven wrote:
> Now all Linux installers that decide to install a SMP kernel if they
> encounter
> a MPTABLE already have a "except if it's a P4" exception nowadays..

that assumes that the installer itself has to be a UP kernel, which means
the installation cannot itself serve as a "demo" of the final product in
the fullest possible capacity... Not good, can't we workaround that
somehow during parsing of the mp table?

Regards,
Tigran

