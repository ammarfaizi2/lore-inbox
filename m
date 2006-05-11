Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbWEKPoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbWEKPoF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 11:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbWEKPoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 11:44:04 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:14736 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030285AbWEKPoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 11:44:02 -0400
Subject: Re: [PATCH] ide_cs: Add IBM microdrive to known IDs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Thomas Kleffel (maintech GmbH)" <tk@maintech.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44629CF4.1070008@maintech.de>
References: <44629CF4.1070008@maintech.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 11 May 2006 16:56:19 +0100
Message-Id: <1147362980.26130.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-05-11 at 04:09 +0200, Thomas Kleffel (maintech GmbH) wrote:
> +       PCMCIA_DEVICE_PROD_ID12("IBM", "microdrive", 0xb569a6e5,
> 0xa6d76178),

I've added this ID to the libata pata_pcmcia driver. Thanks

Alan

