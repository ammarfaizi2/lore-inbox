Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268243AbTGINCQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 09:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268235AbTGINCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 09:02:15 -0400
Received: from host81-136-219-32.in-addr.btopenworld.com ([81.136.219.32]:50513
	"EHLO mx.homelinux.com") by vger.kernel.org with ESMTP
	id S268243AbTGINCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 09:02:12 -0400
Date: Wed, 9 Jul 2003 14:16:46 +0100 (BST)
From: Mitch@0Bits.COM
X-X-Sender: mitch@mx.homelinux.com
Reply-To: Mitch@0Bits.COM
To: linux-kernel@vger.kernel.org
cc: roubm9am@barbora.ms.mff.cuni.cz
Subject: Re: Promise SATA 150 TX2 plus
Message-ID: <Pine.LNX.4.53.0307091413030.683@mx.homelinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Hits: -0.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I believe that is the Promise PDC 20736 controller
for which there is no current driver yet. Search in

	http://marc.theaimsgroup.com/?l=linux-kernel&r=1&b=200307&w=2

for "20736" and read the thread(s) there.

Cheers
M

Milan Roubal wrote:
> Hi,
> I got one card SATA 150 TX2 plus with version v1.00.0.20 on chip.
> I want to make it working under SuSE linux 8.0. I have downloaded
> drivers from www.promise.com, but driver is not working, because of bad
> major/minor numbers of /dev/sda, /dev/sda1, /dev/sdb, .....
> What are the major/minor numbers for making it work?
>
> Or is there any other driver that I should use for making this card =
> working?
> What are major/minor numbers for that drivers?
> Thanks very much for your answers.
