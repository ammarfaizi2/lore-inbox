Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281500AbRKHKg4>; Thu, 8 Nov 2001 05:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281509AbRKHKgr>; Thu, 8 Nov 2001 05:36:47 -0500
Received: from pcow035o.blueyonder.co.uk ([195.188.53.121]:1036 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S281507AbRKHKgg>;
	Thu, 8 Nov 2001 05:36:36 -0500
Date: Thu, 8 Nov 2001 10:36:59 +0000
From: Ian Molton <imolton@clara.net>
To: linux-kernel@vger.kernel.org
Subject: IDE byte counting
Message-Id: <20011108103659.24f75c30.imolton@clara.net>
Reply-To: spyro@armlinux.org
Organization: The dragon roost
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to get a count of how much data has been read / written to
an IDE device?

I thought it'd be neat to modify one of the multitude of netload applaets
to do 'diskload', but Im not sure the kernel provides such data.

Thanks
