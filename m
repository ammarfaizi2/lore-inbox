Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262519AbRENVvM>; Mon, 14 May 2001 17:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262516AbRENVvD>; Mon, 14 May 2001 17:51:03 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:2156 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262513AbRENVuz>; Mon, 14 May 2001 17:50:55 -0400
Date: Mon, 14 May 2001 17:50:47 -0400
From: Bill Nottingham <notting@redhat.com>
To: Jesper Juhl <juhl@eisenstein.dk>
Cc: linux-serial@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missing return value from pci_xircom_fn() in drivers/char/serial.c
Message-ID: <20010514175047.A19221@devserv.devel.redhat.com>
Mail-Followup-To: Jesper Juhl <juhl@eisenstein.dk>,
	linux-serial@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
In-Reply-To: <3AFEFD06.9010500@eisenstein.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AFEFD06.9010500@eisenstein.dk>; from juhl@eisenstein.dk on Sun, May 13, 2001 at 11:30:46PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl (juhl@eisenstein.dk) said: 
> I have made a patch against 2.4.4-ac8 that makes the change, it is 
> below. I guess someone more knowledgeable than me can probably see if 
> this is correct. If this is completely bogus, then please just disregard 
> this email.

Yup, it's right. My bad. :)

Bill
