Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290828AbSARVOv>; Fri, 18 Jan 2002 16:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290824AbSARVOp>; Fri, 18 Jan 2002 16:14:45 -0500
Received: from pizda.ninka.net ([216.101.162.242]:16278 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290825AbSARVOd> convert rfc822-to-8bit;
	Fri, 18 Jan 2002 16:14:33 -0500
Date: Fri, 18 Jan 2002 13:13:09 -0800 (PST)
Message-Id: <20020118.131309.45713681.davem@redhat.com>
To: groudier@free.fr
Cc: hozer@drgw.net, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        rmk@arm.linux.org.uk, dan@embeddededge.com, mattl@mvista.com
Subject: Re: pci_alloc_consistent from interrupt == BAD
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020118215449.K2042-100000@gerard>
In-Reply-To: <20020118.123837.21900127.davem@redhat.com>
	<20020118215449.K2042-100000@gerard>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Gérard Roudier <groudier@free.fr>
   Date: Fri, 18 Jan 2002 22:07:09 +0100 (CET)
   
   Under Linux, PCI consistent allocation support is a requirement. Let me
   cross fingers for this to stay as it is. :)

It is my intention to keep it like this.  I have shown 3 or 4 ports,
after I've been told "we cannot do consistent memory on our platform",
that in fact they could :-)

For this reason, someone will have to do the equivalent of parting the
seas to convince me to change things :-)
