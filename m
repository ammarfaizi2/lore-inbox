Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293128AbSCENy0>; Tue, 5 Mar 2002 08:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293121AbSCENyQ>; Tue, 5 Mar 2002 08:54:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:58753 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293119AbSCENyN> convert rfc822-to-8bit;
	Tue, 5 Mar 2002 08:54:13 -0500
Date: Tue, 05 Mar 2002 05:52:04 -0800 (PST)
Message-Id: <20020305.055204.44939648.davem@redhat.com>
To: linux-kernel@vger.kernel.org, tlan@stud.ntnu.no
Cc: jgarzik@mandrakesoft.com, linux-net@vger.kernel.org
Subject: Re: [BETA-0.95] Sixth test release of Tigon3 driver
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020305143519.A1780@stud.ntnu.no>
In-Reply-To: <20020305.031312.92586410.davem@redhat.com>
	<20020305143519.A1780@stud.ntnu.no>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thomas Langås <tlan@stud.ntnu.no>
   Date: Tue, 5 Mar 2002 14:35:19 +0100
   
   Still won't work with jumboframes and tcp.

Which card do you have?

Also, can you try both changing the MTU during the
initial up of the interface and later after the
interface is up already?  Thanks.

