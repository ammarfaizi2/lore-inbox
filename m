Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317520AbSG2Rj7>; Mon, 29 Jul 2002 13:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317544AbSG2Rj7>; Mon, 29 Jul 2002 13:39:59 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:8187 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317520AbSG2Rj7>; Mon, 29 Jul 2002 13:39:59 -0400
Subject: Re: oops with usb-serial converter
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Peter <pk@q-leap.com>, linux-kernel@vger.kernel.org, johannes@erdfelt.com
In-Reply-To: <20020729173724.GA10153@kroah.com>
References: <S.0001006613@wolnet.de>  <20020729173724.GA10153@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 Jul 2002 19:58:32 +0100
Message-Id: <1027969112.4101.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-29 at 18:37, Greg KH wrote:
> Can you see if the 2.5.29 kernel fixes this problem?  The usb-serial
> close() call has been modified to hopefully prevent this from happening
> in the 2.5 tree.

If you do - make a backup before you try it

