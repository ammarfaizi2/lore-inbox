Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312420AbSCUSLD>; Thu, 21 Mar 2002 13:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312421AbSCUSKx>; Thu, 21 Mar 2002 13:10:53 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33292 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312420AbSCUSKh>; Thu, 21 Mar 2002 13:10:37 -0500
Subject: Re: Linux 2.4.19pre3-ac4
To: mfedyk@matchmail.com (Mike Fedyk)
Date: Thu, 21 Mar 2002 18:25:58 +0000 (GMT)
Cc: jamagallon@able.es (J.A. Magallon),
        akropel1@rochester.rr.com (Adam Kropelin),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020321180516.GD3201@matchmail.com> from "Mike Fedyk" at Mar 21, 2002 10:05:16 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16o7GA-0005v1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I think it gives about 100k size decrease IFF you have verbose BUG activated.
> 
> Wasn't that config option removed (I haven't checked...) with this patch?

The patch with it does yes. All BUG()'s are now small
